import sys, os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
# Add the current app directory to the system path for proper imports
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Import database base class and engine
from backend.app.database import Base, engine

# Import routers
from backend.app.routers import habits
from backend.app.routers import ai
from backend.app.auth import routes as auth_routes

# Automatically create database tables (only if they don't exist)
Base.metadata.create_all(bind=engine)

# Initialize FastAPI application
app = FastAPI(title="Habit-AI Backend")

# Enable CORS middleware so the frontend can access the backend API
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # You can replace "*" with "http://localhost:3000" for security
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Register all routers
app.include_router(habits.router)
app.include_router(ai.router)
app.include_router(auth_routes.router)

# Root endpoint (for testing API connection)
@app.get("/")
def root():
    return {"message": "Habit-AI Backend running on PostgreSQL"}



