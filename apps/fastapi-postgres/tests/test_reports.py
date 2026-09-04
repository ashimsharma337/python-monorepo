from fastapi.testclient import TestClient
from app.main import app
import app.services.report_service as service


class FakeCursor:
    def __init__(self):
        self.last_query = None
        self.last_params = None
        self._rows = [
            (1, "Alice", "US", 2, 5, 150.0),
            (2, "Bob", "CA", 1, 2, 50.0),
        ]

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, tb):
        return False

    def execute(self, query, params=None):
        self.last_query = query
        self.last_params = params or []

    def fetchall(self):
        return self._rows


class FakeConnection:
    def cursor(self):
        return FakeCursor()


def test_get_customer_sales(monkeypatch):
    monkeypatch.setattr(service, "get_connection", lambda: FakeConnection())
    monkeypatch.setattr(service, "release_connection", lambda conn: None)
    client = TestClient(app)
    resp = client.get("/reports/customer-sales")
    assert resp.status_code == 200
    data = resp.json()
    assert isinstance(data, list)
    assert data[0]["customer_id"] == 1 or data[0]["customer_id"] == 1


def test_post_query_filters(monkeypatch):
    fake_cursor = FakeCursor()

    class C(FakeConnection):
        def cursor(self):
            return fake_cursor

    monkeypatch.setattr(service, "get_connection", lambda: C())
    monkeypatch.setattr(service, "release_connection", lambda conn: None)
    client = TestClient(app)
    payload = {"filters": {"country": "US", "min_spent": 100}, "limit": 10, "offset": 0}
    resp = client.post("/reports/customer-sales/query", json=payload)
    assert resp.status_code == 200
    data = resp.json()
    assert isinstance(data, list)
    # ensure execute received params including our filters
    assert fake_cursor.last_params is not None
    assert any(p == "US" or p == 100 for p in fake_cursor.last_params)
