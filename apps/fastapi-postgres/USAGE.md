FastAPI-Postgres — Quick Usage
================================

What this app does
-------------------
- Exposes read-only REST endpoints to query ecommerce customer sales data stored in Postgres.
- Provides a safe, whitelist-driven dynamic query endpoint to filter and paginate results.

Primary endpoints
-----------------
- GET /reports/customer-sales
  - Returns the default customer sales report (customers with COMPLETED orders, aggregated totals).
- POST /reports/customer-sales/query
  - Accepts a JSON body matching the `QueryRequest` model with optional keys:
    - `filters`: object with whitelisted filter keys: `country`, `customer_name`, `min_spent`, `max_spent`, `min_orders`, `max_orders`.
    - `limit`: integer (pagination limit, default 100)
    - `offset`: integer (pagination offset, default 0)

Examples
--------
- Request body for POST /reports/customer-sales/query:

```json
{
  "filters": {"country": "US", "customer_name": "Smith", "min_spent": 100},
  "limit": 50,
  "offset": 0
}
```

How to run
----------
1. Create a virtual environment and install deps:

```bash
cd apps/fastapi-postgres
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

2. Configure database connection in `.env` (copy from `.env.example`).

3. Start server:

```bash
uvicorn app.main:app --reload
```

4. Open Swagger UI in the browser: `http://127.0.0.1:8000/docs` to explore endpoints.

Testing and example client
--------------------------
- Run unit tests (uses pytest):

```bash
pytest -q
```

- Example client script: `scripts/example_client.py` — runs two calls (GET and POST). Install deps and run it:

```bash
python3 scripts/example_client.py
```

Design notes & safety
---------------------
- The dynamic query endpoint only accepts a small whitelist of filters and always uses parameterized SQL to prevent SQL injection.
- A `controllers` layer was added to separate HTTP concerns from business/data logic.
- Logging is configured in `app/main.py` and used by services/controllers.

If you want additional filters, aggregation options, or a new report, say which fields and I will add them and update tests.
