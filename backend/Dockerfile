# ---------------------------
# Backend Dockerfile for FastAPI
# ---------------------------

# Base image with Python 3.12
FROM python:3.12-slim

# Set working directory to /app (project root)
WORKDIR /app

# Copy entire project into container
COPY . .

# Install dependencies from backend/app/requirements.txt
RUN pip install --no-cache-dir -r backend/app/requirements.txt

# Expose FastAPI port
EXPOSE 8000

# Run FastAPI server
CMD ["uvicorn", "backend.app.main:app", "--host", "0.0.0.0", "--port", "8000"]
