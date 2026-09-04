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
│   ├── controllers/
│   │   ├── __init__.py
│   │   └── reports_controller.py
│   ├── database.py
│   ├── main.py
│   ├── models.py
│   ├── routers/
│   │   ├── reports.py
│   │   └── users.py
│   └── services/
│       ├── __init__.py
│       └── report_service.py
├── scripts/
│   └── example_client.py
├── sql/
│   ├── queries.sql
│   ├── schema.sql
│   └── seed.sql
├── tests/
│   └── test_reports.py
├── .dockerIgnore
├── .env.example
├── .gitignore
├── Dockerfile
├── requirements.txt
├── README.md
└── USAGE.md
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
http://127.0.0.1:8000/docs
```

It is generated automatically from the FastAPI application and its route definitions.