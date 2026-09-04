"""Example client script for the reports endpoints.
    python scripts/example_client.py
"""
import sys

try:
    import requests
except ModuleNotFoundError:
    print(
        "Missing dependency 'requests'. Install with:\n  python3 -m pip install -r requirements.txt"
    )
    sys.exit(1)

BASE = "http://localhost:8000"


def get_customer_sales():
    r = requests.get(f"{BASE}/reports/customer-sales")
    print("GET /reports/customer-sales ->", r.status_code)
    try:
        print(r.json())
    except Exception:
        print(r.text)


def post_query():
    payload = {
        "filters": {"country": "US", "customer_name": "Alice", "min_spent": 100},
        "limit": 50,
        "offset": 0,
    }
    r = requests.post(f"{BASE}/reports/customer-sales/query", json=payload)
    print("POST /reports/customer-sales/query ->", r.status_code)
    try:
        print(r.json())
    except Exception:
        print(r.text)


if __name__ == "__main__":
    get_customer_sales()
    post_query()
