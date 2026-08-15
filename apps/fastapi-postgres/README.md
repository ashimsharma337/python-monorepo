# FastAPI PostgreSQL API

A FastAPI application that provides REST APIs for reading data from PostgreSQL.

## Tech Stack

- Python 3.13
- FastAPI
- Uvicorn
- PostgreSQL
- psycopg2
- python-dotenv

## Project Structure

```text
fastapi-postgres/
├── app/
│   ├── __init__.py
│   ├── main.py
│   └── routers/
│       └── __init__.py
├── tests/
├── .env.example
├── .gitignore
├── requirements.txt
└── README.md
```

## Swagger UI

- FastAPI automatically provides Swagger UI, an interactive API documentation interface.

### It allows you to:
- See all available API endpoints
- View request/response schemas
- Execute API requests directly from the browser
- Test APIs without using Postman or another API client

FastAPI Swagger UI is available at:
```bash
http://yourip:8000/docs
```

It is generated automatically from the FastAPI application and its route definitions.