from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from backend.app.database import get_db
from backend.app import models
import requests
import os
from datetime import datetime, timedelta, time
import random
from dotenv import load_dotenv

load_dotenv()

router = APIRouter(prefix="/ai", tags=["AI Suggestions"])

HUGGINGFACE_API_URL = "https://router.huggingface.co/v1/chat/completions"
MODEL_NAME = "meta-llama/Llama-3.2-3B-Instruct"
HUGGINGFACE_API_KEY = os.getenv("HUGGINGFACE_API_KEY")


def round_to_nearest_half_hour(dt: datetime):
    """Round given datetime to nearest 00 or 30 minute mark"""
    minute = 0 if dt.minute < 15 else (30 if dt.minute < 45 else 0)
    hour = dt.hour if dt.minute < 45 else (dt.hour + 1) % 24
    return dt.replace(hour=hour, minute=minute, second=0, microsecond=0)


def get_reasonable_time_window(now: datetime, habit_name: str):
    """Return a reasonable suggestion time range based on habit type and current time."""
    # Define base preferred hours for different habit types
    morning = (6, 10)
    midday = (11, 14)
    evening = (17, 21)

    lower_habit = habit_name.lower()

    if any(x in lower_habit for x in ["run", "jog", "walk", "exercise", "gym"]):
        start_hour = random.randint(*morning)
    elif any(x in lower_habit for x in ["study", "work", "read", "learn"]):
        start_hour = random.randint(*evening)
    elif any(x in lower_habit for x in ["meditate", "relax", "sleep"]):
        start_hour = random.randint(21, 23)
    else:
        # generic fallback: sometime soon in the day
        start_hour = random.randint(8, 20)

    today_start = now.replace(hour=start_hour, minute=0, second=0, microsecond=0)
    # if this time already passed, schedule for next available slot
    if today_start < now:
        today_start = round_to_nearest_half_hour(now + timedelta(hours=1))

    start_time = round_to_nearest_half_hour(today_start)
    end_time = (start_time + timedelta(hours=1)).replace(second=0, microsecond=0)
    return start_time, end_time


@router.get("/suggestion/{user_id}")
def get_ai_suggestion(user_id: int, db: Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    habits = (
        db.query(models.Habit)
        .filter(models.Habit.owner_id == user_id)
        .order_by(models.Habit.start_time.desc())
        .limit(50)
        .all()
    )

    if not habits:
        return {"suggestion": "No habits found for this user."}

    now = datetime.now()
    now_str = now.strftime("%A, %Y-%m-%d %H:%M")

    incomplete = [h for h in habits if not h.completed]
    overdue = max(incomplete, key=lambda h: h.start_time) if incomplete else habits[0]
    habit_name = overdue.title
    days_since = (now - overdue.start_time).days

    start_suggest, end_suggest = get_reasonable_time_window(now, habit_name)
    time_window = f"{start_suggest.strftime('%H:%M')}–{end_suggest.strftime('%H:%M')}"

    user_prompt = (
        f"The current time is {now_str}. The user hasn't done '{habit_name}' for {days_since} days. "
        f"Generate a single short motivational English suggestion (<20 words) that recommends doing it "
        f"today at {time_window}. The sentence should be natural, human-like, and action-focused. "
        f"Example: “You haven’t studied for 3 days. How about 1 hour at 18:00–19:00 tonight?”"
    )

    headers = {
        "Authorization": f"Bearer {HUGGINGFACE_API_KEY}",
        "Content-Type": "application/json",
    }

    payload = {
        "model": MODEL_NAME,
        "messages": [
            {"role": "system", "content": "You are a concise, time-specific motivational assistant."},
            {"role": "user", "content": user_prompt},
        ],
        "max_tokens": 60,
        "temperature": 0.8,
        "top_p": 0.9,
    }

    try:
        resp = requests.post(HUGGINGFACE_API_URL, headers=headers, json=payload, timeout=60)
        print(">>> HF API status:", resp.status_code)
        print(">>> HF API response (truncated):", resp.text[:400])

        if resp.status_code != 200:
            raise HTTPException(status_code=resp.status_code, detail=resp.text)

        data = resp.json()
        suggestion = data["choices"][0]["message"]["content"].strip()

        # fallback if empty
        if not suggestion:
            suggestion = f"You haven’t done {habit_name} for {days_since} days. Try it around {time_window} today!"

        return {"suggestion": suggestion}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
