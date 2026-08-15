# Python Monorepo

A collection of Python applications and shared packages maintained in a single Git repository.

The goal of this repository is to provide a single place to build and experiment with multiple Python applications using different frameworks and technologies.

## Repository Structure

```text
python-monorepo/
│
├── apps/
│   │
│   ├── fastapi-postgres/
│   │   ├── app/
│   │   │   ├── main.py
│   │   │   ├── database.py
│   │   │   └── routers/
│   │   ├── tests/
│   │   ├── .env.example
│   │   ├── requirements.txt
│   │   └── Dockerfile
│   │
│   ├── flask-api/
│   │   └── ...
│   │
│   └── django-app/
│       └── ...
│
├── packages/
│   └── common/
│       └── ...
│
├── .gitignore
├── README.md
└── pyproject.toml
```

## Why a Monorepo?

All related Python applications live in one repository while remaining independently runnable and deployable.

For example:

```text
apps/
├── fastapi-postgres/
├── fastapi-search/
├── flask-api/
├── django-app/
└── data-ingestion/
```

Each application can have its own:

* Dependencies
* Virtual environment
* Configuration
* Tests
* Dockerfile
* CI/CD pipeline
* Deployment

This keeps applications independent while making it easy to manage them from a single repository.

## Applications

### FastAPI PostgreSQL

`apps/fastapi-postgres`

A FastAPI application that exposes APIs backed by PostgreSQL.

Planned technologies:

* Python
* FastAPI
* PostgreSQL
* Psycopg
* Connection pooling
* AWS RDS
* SSL/TLS
* Docker
* Kubernetes

The application will primarily expose predefined PostgreSQL `SELECT` queries through API endpoints.

Architecture:

```text
Client Application
       │
       │ HTTP
       ▼
FastAPI
       │
       ▼
APIRouter
       │
       ▼
Service / Database Layer
       │
       ▼
Connection Pool
       │
       ▼
PostgreSQL / AWS RDS
```

## Shared Packages

The `packages/` directory contains reusable Python code shared between applications.

Example:

```text
packages/
└── common/
    ├── logging/
    ├── database/
    └── utils/
```

Shared code should only be added here when it is genuinely useful across multiple applications.

## Local Development

Each application can have its own Python virtual environment.

For example:

```bash
cd apps/fastapi-postgres

python3 -m venv .venv
source .venv/bin/activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Run the FastAPI application:

```bash
uvicorn app.main:app --reload
```

The API will be available at:

```text
http://127.0.0.1:8000
```

Swagger UI:

```text
http://127.0.0.1:8000/docs
```

## Environment Variables

Applications should keep environment-specific configuration in `.env` files during local development.

Example:

```text
DB_HOST=
DB_PORT=5432
DB_NAME=
DB_USER=
DB_PASSWORD=

DB_SSL_MODE=
DB_SSL_ROOT_CERT=
```

Never commit real credentials or secrets to Git.

Commit `.env.example` files instead.

## PostgreSQL Connection Pooling

The `fastapi-postgres` application will use PostgreSQL connection pooling instead of creating a new database connection for every request.

Conceptually:

```text
                  FastAPI
                     │
                     ▼
             Connection Pool
             ┌───────┼───────┐
             │       │       │
           Conn 1  Conn 2  Conn 3 ...
             │       │       │
             └───────┼───────┘
                     │
                     ▼
                 PostgreSQL
```

The initial pool configuration will be kept intentionally small and tuned based on actual application usage.

## Security

For AWS RDS PostgreSQL, database connections will use TLS/SSL.

Production connections will use certificate verification:

```text
sslmode=verify-full
```

The application will use the AWS RDS CA certificate to verify the PostgreSQL server.

Local development can support both:

```text
FastAPI → Local PostgreSQL
```

and:

```text
FastAPI → AWS RDS PostgreSQL
             │
             └── TLS
```

## Docker

Each independently deployable application can have its own Dockerfile.

Example:

```text
apps/
└── fastapi-postgres/
    └── Dockerfile
```

This allows the application to be built and deployed independently from the other applications in the monorepo.

## Future Applications

Additional applications can be added under `apps/`:

```text
apps/
├── fastapi-postgres/
├── fastapi-search/
├── flask-api/
├── django-app/
└── data-ingestion/
```

The repository can therefore grow into a collection of independent Python services and applications while remaining a single Git repository.

## Goals

This repository is also a learning and experimentation environment for:

* Python
* FastAPI
* Flask
* Django
* PostgreSQL
* Redis
* REST APIs
* GraphQL
* Docker
* Kubernetes
* AWS
* CI/CD
* Testing
* Python application architecture

The focus is on building applications using practical, production-oriented patterns rather than keeping each project as a standalone tutorial.
