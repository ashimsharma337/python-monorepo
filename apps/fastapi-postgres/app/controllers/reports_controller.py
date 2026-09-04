import logging
from typing import Any
from app.models import QueryRequest
from app.services import report_service

logger = logging.getLogger(__name__)


def customer_sales() -> Any:
    """Controller for the simple GET customer sales endpoint.

    Returns the default report from the service layer.
    """
    try:
        return report_service.get_customer_sales()
    except Exception as exc:
        logger.exception("Error fetching customer sales")
        raise


def customer_sales_query(request: QueryRequest) -> Any:
    """Controller for the dynamic POST query endpoint.

    Accepts a validated `QueryRequest` and forwards it to the service.
    """
    try:
        return report_service.query_customer_sales(request)
    except Exception:
        logger.exception("Error executing customer sales query; filters=%s", getattr(request, "filters", None))
        raise
