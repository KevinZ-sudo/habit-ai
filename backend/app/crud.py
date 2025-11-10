from sqlalchemy.orm import Session
from backend.app import models, schemas
from backend.app.auth.hashing import hash_password

# users API
def create_user(db: Session, user: schemas.UserCreate):
    hashed_pw = hash_password(user.password)
    db_user = models.User(username=user.username, email=user.email, hashed_password=hashed_pw)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def get_user_by_email(db: Session, email: str):
    return db.query(models.User).filter(models.User.email == email).first()

# habit API
def get_habits(db: Session):
    return db.query(models.Habit).all()

def create_habit(db: Session, habit: schemas.HabitCreate, owner_id: int):

    db_habit = models.Habit(
        title=habit.title,
        completed=habit.completed,
        start_time=habit.start_time,
        end_time=habit.end_time,
        owner_id=owner_id,
    )
    db.add(db_habit)
    db.commit()
    db.refresh(db_habit)
    return db_habit
