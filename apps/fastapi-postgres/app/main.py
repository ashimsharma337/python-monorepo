from fastapi import FastAPI
import logging
from app.routers.reports import router as reports_router

# Configure basic logging for the app
logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s [%(name)s] %(message)s")

app = FastAPI(
    title="Postgres API",
    version="1.0.0",
)

app.include_router(reports_router)


# ----------- health endpoint
@app.get("/health")
def health():
    return {"status": "ok"}