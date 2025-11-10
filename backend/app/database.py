import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

# Smart fallback logic
if not DATABASE_URL or "@db" in DATABASE_URL or DATABASE_URL.strip() == "":
    # Default for local Docker Compose
    DATABASE_URL = "postgresql+psycopg2://postgres:yourpassword@db:5432/habit_ai"
elif DATABASE_URL.startswith("postgres://"):
    # Normalize legacy Render URLs
    DATABASE_URL = DATABASE_URL.replace("postgres://", "postgresql://")

print(f"Using database: {DATABASE_URL}")

engine = create_engine(
    DATABASE_URL,
    pool_pre_ping=True,
    pool_size=5,
    max_overflow=10
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
