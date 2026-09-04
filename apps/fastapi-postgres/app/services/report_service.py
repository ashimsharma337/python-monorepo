import logging
from app.database import get_connection, release_connection
from app.models import QueryRequest


logger = logging.getLogger(__name__)


def get_customer_sales():
    # Backwards-compatible helper that returns the default report
    return query_customer_sales(QueryRequest())


def query_customer_sales(request: QueryRequest):
    """Build and execute a safe dynamic customer sales query.

    Only a whitelist of filter keys is accepted to avoid arbitrary SQL execution.
    Supported filters:
      - country: exact match
      - customer_name: substring match (ILIKE)
      - min_spent / max_spent: numeric filter on SUM(...) (uses HAVING)
      - min_orders / max_orders: numeric filter on COUNT(...) (uses HAVING)
    """
    connection = get_connection()

    try:
        with connection.cursor() as cursor:

            base_query = (
                """
                SELECT
                    c.id AS customer_id,
                    c.name AS customer_name,
                    c.country,
                    COUNT(DISTINCT o.id) AS order_count,
                    SUM(oi.quantity) AS total_items,
                    SUM(oi.quantity * oi.unit_price) AS total_spent
                FROM ecommerce.customers c
                JOIN ecommerce.orders o
                    ON c.id = o.customer_id
                JOIN ecommerce.order_items oi
                    ON o.id = oi.order_id
                WHERE o.status = 'COMPLETED'
                """
            )

            params = []
            filters = request.filters or {}

            allowed_where = {
                "country": ("c.country = %s", lambda v: v),
                "customer_name": ("c.name ILIKE %s", lambda v: f"%{v}%"),
            }

            having_map = {
                "min_spent": ("SUM(oi.quantity * oi.unit_price) >= %s", lambda v: v),
                "max_spent": ("SUM(oi.quantity * oi.unit_price) <= %s", lambda v: v),
                "min_orders": ("COUNT(DISTINCT o.id) >= %s", lambda v: v),
                "max_orders": ("COUNT(DISTINCT o.id) <= %s", lambda v: v),
            }

            where_clauses = []
            having_clauses = []

            for k, v in filters.items():
                if k in allowed_where:
                    tmpl, conv = allowed_where[k]
                    where_clauses.append(tmpl)
                    params.append(conv(v))
                elif k in having_map:
                    tmpl, conv = having_map[k]
                    having_clauses.append(tmpl)
                    params.append(conv(v))
                else:
                    logger.debug("Ignoring unsupported filter: %s", k)

            if where_clauses:
                base_query += " AND " + " AND ".join(where_clauses)

            base_query += "\nGROUP BY c.id, c.name, c.country"

            if having_clauses:
                base_query += "\nHAVING " + " AND ".join(having_clauses)

            base_query += "\nORDER BY total_spent DESC"

            # pagination
            if request.limit:
                base_query += "\nLIMIT %s"
                params.append(request.limit)
            if request.offset:
                base_query += "\nOFFSET %s"
                params.append(request.offset)

            logger.info("Executing customer_sales query; params=%s", params)
            cursor.execute(base_query, params)
            rows = cursor.fetchall()

            return [
                {
                    "customer_id": row[0],
                    "customer_name": row[1],
                    "country": row[2],
                    "order_count": row[3],
                    "total_items": row[4],
                    "total_spent": float(row[5]),
                }
                for row in rows
            ]

    finally:
        release_connection(connection)
import logging

from app.database import get_connection, release_connection
from app.models import QueryRequest


logger = logging.getLogger(__name__)


def get_customer_sales():
    # Backwards-compatible helper that returns the default report
    return query_customer_sales(QueryRequest())


def query_customer_sales(request: QueryRequest):
    """Build and execute a safe dynamic customer sales query.

    Only a whitelist of filter keys is accepted to avoid arbitrary SQL execution.
    Supported filters:
      - country: exact match
      - customer_name: substring match (ILIKE)
      - min_spent / max_spent: numeric filter on SUM(...) (uses HAVING)
      - min_orders / max_orders: numeric filter on COUNT(...) (uses HAVING)
    """
    connection = get_connection()

    try:
        with connection.cursor() as cursor:

            base_query = (
                """
                SELECT
                    c.id AS customer_id,
                    c.name AS customer_name,
                    c.country,
                    COUNT(DISTINCT o.id) AS order_count,
                    SUM(oi.quantity) AS total_items,
                    SUM(oi.quantity * oi.unit_price) AS total_spent
                FROM ecommerce.customers c
                JOIN ecommerce.orders o
                    ON c.id = o.customer_id
                JOIN ecommerce.order_items oi
                    ON o.id = oi.order_id
                WHERE o.status = 'COMPLETED'
                """
            )

            params = []
            filters = request.filters or {}

            allowed_where = {
                "country": ("c.country = %s", lambda v: v),
                "customer_name": ("c.name ILIKE %s", lambda v: f"%{v}%"),
            }

            having_map = {
                "min_spent": ("SUM(oi.quantity * oi.unit_price) >= %s", lambda v: v),
                "max_spent": ("SUM(oi.quantity * oi.unit_price) <= %s", lambda v: v),
                "min_orders": ("COUNT(DISTINCT o.id) >= %s", lambda v: v),
                "max_orders": ("COUNT(DISTINCT o.id) <= %s", lambda v: v),
            }

            where_clauses = []
            having_clauses = []

            for k, v in filters.items():
                if k in allowed_where:
                    tmpl, conv = allowed_where[k]
                    where_clauses.append(tmpl)
                    params.append(conv(v))
                elif k in having_map:
                    tmpl, conv = having_map[k]
                    having_clauses.append(tmpl)
                    params.append(conv(v))
                else:
                    logger.debug("Ignoring unsupported filter: %s", k)

            if where_clauses:
                base_query += " AND " + " AND ".join(where_clauses)

            base_query += "\nGROUP BY c.id, c.name, c.country"

            if having_clauses:
                base_query += "\nHAVING " + " AND ".join(having_clauses)

            base_query += "\nORDER BY total_spent DESC"

            # pagination
            if request.limit:
                base_query += "\nLIMIT %s"
                params.append(request.limit)
            if request.offset:
                base_query += "\nOFFSET %s"
                params.append(request.offset)

            logger.info("Executing customer_sales query; params=%s", params)
            cursor.execute(base_query, params)
            rows = cursor.fetchall()

            return [
                {
                    "customer_id": row[0],
                    "customer_name": row[1],
                    "country": row[2],
                    "order_count": row[3],
                    "total_items": row[4],
                    "total_spent": float(row[5]),
                }
                for row in rows
            ]

    finally:
        release_connection(connection)