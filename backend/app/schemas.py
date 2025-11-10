from datetime import datetime
from typing import List, Optional
from pydantic import BaseModel, EmailStr


# ==========================
# User Schemas
# ==========================

class UserBase(BaseModel):
    email: EmailStr

class UserCreate(UserBase):
    username: str
    password: str

class UserOut(UserBase):
    id: int
    username: str

    class Config:
        from_attributes = True


# ==========================
# Habit Schemas
# ==========================

class HabitBase(BaseModel):
    title: str
    completed: bool = False


class HabitCreate(HabitBase):
    start_time: datetime
    end_time: datetime


class HabitOut(HabitBase):
    id: int
    start_time: datetime
    end_time: datetime
    owner_id: int

class HabitUpdate(BaseModel):
    title: Optional[str] = None
    completed: Optional[bool] = None
    start_time: Optional[datetime] = None
    end_time: Optional[datetime] = None

    class Config:
        from_attributes = True


# ==========================
# Token Schemas (Auth)
# ==========================

class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    username: Optional[str] = None


# ==========================
# Extended (User with Habits)
# ==========================

class UserWithHabits(UserOut):
    habits: List[HabitOut] = []

    class Config:
        from_attributes = True
