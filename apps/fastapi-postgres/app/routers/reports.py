from fastapi import APIRouter
from app.controllers.reports_controller import customer_sales, customer_sales_query
from app.models import QueryRequest


router = APIRouter(
    prefix="/reports",
    tags=["Reports"],
)


@router.get("/customer-sales")
def get_customer_sales():
    return customer_sales()


@router.post("/customer-sales/query")
def post_customer_sales_query(request: QueryRequest):
    return customer_sales_query(request)