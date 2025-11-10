# Habit-AI

**Habit-AI** is a full-stack habit tracking web application powered by FastAPI, React, and PostgreSQL.  
It allows users to manage daily habits, track progress, and receive AI-generated activity suggestions.

---

## Quick Start

### Prerequisites
- Docker and Docker Compose installed on your system

### Run the application
In the project root directory (`habit-ai/`), execute:

```bash
docker compose up --build
```

After the containers start:

- Frontend: [http://localhost:3000](http://localhost:3000)  
- Backend API Docs: [http://localhost:8000/docs](http://localhost:8000/docs)

---

## Test Account

You can log in with the following demo account:

- **Email:** `testemail@test.com`  
- **Password:** `pwd1`

This account includes **100 habit records**, providing a realistic dataset for exploring the app’s AI recommendation features.

---

## Notes

- The entire stack (frontend, backend, and database) runs inside Docker containers.  
- To stop all running containers, press `Ctrl + C` or run:
  ```bash
  docker compose down
  ```

---

## Author

Developed by **Kevin(Kaihuan) Zheng**  
