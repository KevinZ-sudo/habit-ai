# Habit-AI

**Habit-AI** is a full-stack habit tracking web application powered by FastAPI, React, and PostgreSQL.  
It allows users to manage daily habits, track progress, and receive AI-generated activity suggestions.

---

## Quick Start

### Prerequisites
- Docker and Docker Compose installed on your system
- A valid **Hugging Face API Token** for enabling AI recommendation features

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
- To enable AI functionalities, you must provide your **Hugging Face API Token**:
  1. Create an account at [https://huggingface.co](https://huggingface.co)
  2. Go to **Settings → Access Tokens**
  3. Copy your token and add it to your environment file:
     ```
     HUGGINGFACE_API_KEY=your_token_here
     ```
  4. Restart your containers.
- Use the provided `.env.example` template to create your own `.env` file.  
  Rename it to `.env` and fill in the required values such as your Hugging Face API key and database URL.

---

## Author

Developed by **Kevin(Kaihuan) Zheng**
