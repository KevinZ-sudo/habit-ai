from backend.app.database import SessionLocal
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from backend.app import models, schemas, database, crud
from backend.app.auth.utils import get_current_user
from datetime import datetime, timedelta

router = APIRouter(prefix="/habits", tags=["Habits"])

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/", response_model=list[schemas.HabitOut])
def get_all_habits(db: Session = Depends(get_db)):
    return crud.get_habits(db)

@router.post("/", response_model=schemas.HabitOut)
def create_new_habit(habit: schemas.HabitCreate, db: Session = Depends(get_db)):
    return crud.create_habit(db, habit, owner_id=1)  # demo user

router = APIRouter(prefix="/habits", tags=["Habits"])

# get habits
@router.get("/", response_model=list[schemas.HabitOut])
def get_habits(db: Session = Depends(database.get_db),
               current_user: models.User = Depends(get_current_user)):
    habits = db.query(models.Habit).filter(models.Habit.owner_id == current_user.id).all()
    return habits


# create habits
@router.post("/", response_model=schemas.HabitOut)
def create_habit(habit: schemas.HabitCreate,
                 db: Session = Depends(database.get_db),
                 current_user: models.User = Depends(get_current_user)):
    db_habit = models.Habit(**habit.dict(), owner_id=current_user.id)
    db.add(db_habit)
    db.commit()
    db.refresh(db_habit)
    return db_habit


# update habits
@router.put("/{habit_id}", response_model=schemas.HabitOut)
def update_habit(habit_id: int, habit: schemas.HabitUpdate,
                 db: Session = Depends(database.get_db),
                 current_user: models.User = Depends(get_current_user)):
    db_habit = db.query(models.Habit).filter(
        models.Habit.id == habit_id,
        models.Habit.owner_id == current_user.id
    ).first()
    if not db_habit:
        raise HTTPException(status_code=404, detail="Habit not found")
    for key, value in habit.dict(exclude_unset=True).items():
        setattr(db_habit, key, value)
    db.commit()
    db.refresh(db_habit)
    return db_habit


# dele habits
@router.delete("/{habit_id}")
def delete_habit(habit_id: int,
                 db: Session = Depends(database.get_db),
                 current_user: models.User = Depends(get_current_user)):
    db_habit = db.query(models.Habit).filter(
        models.Habit.id == habit_id,
        models.Habit.owner_id == current_user.id
    ).first()
    if not db_habit:
        raise HTTPException(status_code=404, detail="Habit not found")
    db.delete(db_habit)
    db.commit()
    return {"message": "Habit deleted successfully"}


# AI advices
@router.get("/ai/advice")
def get_ai_advice(current_user: models.User = Depends(get_current_user)):
    """
    Mock interface: AI advice
    """
    sample_advice = [
        {
            "suggestion": "Try completing your tasks earlier in the day for better consistency.",
            "timestamp": datetime.utcnow().isoformat()
        },
        {
            "suggestion": "You completed 70% of your habits last week. Aim for 80% this week!",
            "timestamp": (datetime.utcnow() - timedelta(days=1)).isoformat()
        }
    ]
    return {
        "user": current_user.username,
        "ai_advice": sample_advice,
        "status": "success"
    }

