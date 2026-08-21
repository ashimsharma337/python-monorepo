-- ============================================================
-- PostgreSQL Query Refresher
-- Database: ecommerce
-- ============================================================


-- ============================================================
-- 1. BASIC SELECT
-- ============================================================

-- Get all customers
SELECT *
FROM ecommerce.customers;


-- Select specific columns
SELECT
    id,
    name,
    email
FROM ecommerce.customers;


-- Filter records
SELECT
    name,
    email,
    country
FROM ecommerce.customers
WHERE country = 'USA';


-- Multiple conditions
SELECT
    name,
    country
FROM ecommerce.customers
WHERE country = 'USA'
  AND name LIKE 'A%';


-- Sorting
SELECT
    name,
    country
FROM ecommerce.customers
ORDER BY name ASC;


-- Limit results
SELECT *
FROM ecommerce.products
ORDER BY price DESC
LIMIT 5;



-- ============================================================
-- 2. INNER JOIN
-- ============================================================

-- Get orders along with customer information.

SELECT
    o.id AS order_id,
    c.name AS customer_name,
    o.status,
    o.order_date
FROM ecommerce.orders o
INNER JOIN ecommerce.customers c
    ON o.customer_id = c.id;


-- INNER JOIN only returns records where both tables match.



-- ============================================================
-- 3. MULTIPLE JOINS
-- ============================================================

-- Get order, customer and product information.

SELECT
    o.id AS order_id,
    c.name AS customer_name,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price
FROM ecommerce.orders o

JOIN ecommerce.customers c
    ON o.customer_id = c.id

JOIN ecommerce.order_items oi
    ON o.id = oi.order_id

JOIN ecommerce.products p
    ON oi.product_id = p.id;



-- ============================================================
-- 4. LEFT JOIN
-- ============================================================

-- Return ALL customers, including customers
-- who have never placed an order.

SELECT
    c.id,
    c.name,
    COUNT(o.id) AS order_count
FROM ecommerce.customers c

LEFT JOIN ecommerce.orders o
    ON c.id = o.customer_id

GROUP BY
    c.id,
    c.name;


-- Important:
--
-- INNER JOIN:
--     Only matching records.
--
-- LEFT JOIN:
--     Everything from the LEFT table
--     + matching records from the right table.



-- ============================================================
-- 5. RIGHT JOIN
-- ============================================================

-- Return all products and matching order items.

SELECT
    p.name,
    oi.quantity
FROM ecommerce.order_items oi

RIGHT JOIN ecommerce.products p
    ON oi.product_id = p.id;


-- RIGHT JOIN is less commonly used.
-- Usually the same query can be written more clearly
-- using LEFT JOIN by changing the table order.



-- ============================================================
-- 6. FULL OUTER JOIN
-- ============================================================

-- Return all customers and all orders,
-- including unmatched records.

SELECT
    c.name,
    o.id AS order_id
FROM ecommerce.customers c

FULL OUTER JOIN ecommerce.orders o
    ON c.id = o.customer_id;



-- ============================================================
-- 7. JOIN + WHERE
-- ============================================================

-- Get only completed orders.

SELECT
    o.id AS order_id,
    c.name AS customer_name,
    o.order_date
FROM ecommerce.orders o

JOIN ecommerce.customers c
    ON o.customer_id = c.id

WHERE o.status = 'COMPLETED';



-- ============================================================
-- 8. AGGREGATE FUNCTIONS
-- ============================================================

-- COUNT
SELECT COUNT(*) AS total_customers
FROM ecommerce.customers;


-- SUM
SELECT SUM(stock_quantity) AS total_stock
FROM ecommerce.products;


-- AVG
SELECT AVG(price) AS average_product_price
FROM ecommerce.products;


-- MIN
SELECT MIN(price) AS cheapest_product
FROM ecommerce.products;


-- MAX
SELECT MAX(price) AS most_expensive_product
FROM ecommerce.products;



-- ============================================================
-- 9. GROUP BY
-- ============================================================

-- Count customers by country.

SELECT
    country,
    COUNT(*) AS customer_count
FROM ecommerce.customers
GROUP BY country;


-- Count orders by status.

SELECT
    status,
    COUNT(*) AS order_count
FROM ecommerce.orders
GROUP BY status;


-- Calculate total revenue by product.

SELECT
    p.name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM ecommerce.products p

JOIN ecommerce.order_items oi
    ON p.id = oi.product_id

JOIN ecommerce.orders o
    ON oi.order_id = o.id

WHERE o.status = 'COMPLETED'

GROUP BY
    p.id,
    p.name

ORDER BY revenue DESC;



-- ============================================================
-- 10. HAVING
-- ============================================================

-- Find customers who spent more than $1,000.

SELECT
    c.name,
    SUM(oi.quantity * oi.unit_price) AS total_spent

FROM ecommerce.customers c

JOIN ecommerce.orders o
    ON c.id = o.customer_id

JOIN ecommerce.order_items oi
    ON o.id = oi.order_id

WHERE o.status = 'COMPLETED'

GROUP BY
    c.id,
    c.name

HAVING SUM(oi.quantity * oi.unit_price) > 1000

ORDER BY total_spent DESC;


-- WHERE filters rows BEFORE GROUP BY.
--
-- HAVING filters groups AFTER GROUP BY.



-- ============================================================
-- 11. DISTINCT
-- ============================================================

-- Get unique countries.

SELECT DISTINCT country
FROM ecommerce.customers;


-- Get unique product categories.

SELECT DISTINCT category
FROM ecommerce.products;



-- ============================================================
-- 12. CASE
-- ============================================================

-- Categorize products based on price.

SELECT
    name,
    price,

    CASE
        WHEN price >= 1000 THEN 'EXPENSIVE'
        WHEN price >= 500 THEN 'MEDIUM'
        ELSE 'AFFORDABLE'
    END AS price_category

FROM ecommerce.products;



-- ============================================================
-- 13. COALESCE
-- ============================================================

-- COALESCE replaces NULL with another value.

SELECT
    c.name,
    COALESCE(COUNT(o.id), 0) AS order_count

FROM ecommerce.customers c

LEFT JOIN ecommerce.orders o
    ON c.id = o.customer_id

GROUP BY
    c.id,
    c.name;



-- ============================================================
-- 14. UNION
-- ============================================================

-- UNION combines results from two SELECT statements.
--
-- Both SELECT statements must have compatible columns.

SELECT
    'CUSTOMER' AS entity_type,
    name
FROM ecommerce.customers

UNION

SELECT
    'PRODUCT' AS entity_type,
    name
FROM ecommerce.products;



-- ============================================================
-- 15. UNION ALL
-- ============================================================

-- UNION ALL also combines results,
-- but does NOT remove duplicates.

SELECT
    'CUSTOMER' AS entity_type,
    name
FROM ecommerce.customers

UNION ALL

SELECT
    'PRODUCT' AS entity_type,
    name
FROM ecommerce.products;



-- ============================================================
-- UNION vs UNION ALL
-- ============================================================

-- UNION:
--     Removes duplicate rows.
--
-- UNION ALL:
--     Keeps duplicates.
--
-- UNION ALL is generally faster because PostgreSQL
-- does not need to perform duplicate elimination.



-- ============================================================
-- 16. SUBQUERY
-- ============================================================

-- Find products that are more expensive
-- than the average product price.

SELECT
    name,
    price
FROM ecommerce.products

WHERE price > (
    SELECT AVG(price)
    FROM ecommerce.products
);



-- ============================================================
-- 17. EXISTS
-- ============================================================

-- Find customers who have placed at least one order.

SELECT
    c.name,
    c.email
FROM ecommerce.customers c

WHERE EXISTS (
    SELECT 1
    FROM ecommerce.orders o
    WHERE o.customer_id = c.id
);



-- ============================================================
-- 18. NOT EXISTS
-- ============================================================

-- Find customers who have never placed an order.

SELECT
    c.name,
    c.email
FROM ecommerce.customers c

WHERE NOT EXISTS (
    SELECT 1
    FROM ecommerce.orders o
    WHERE o.customer_id = c.id
);



-- ============================================================
-- 19. DATE / TIMESTAMP FUNCTIONS
-- ============================================================

-- Orders placed in August 2026.

SELECT *
FROM ecommerce.orders
WHERE order_date >= '2026-08-01'
  AND order_date < '2026-09-01';


-- Extract year and month.

SELECT
    id,
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month
FROM ecommerce.orders;



-- ============================================================
-- 20. STRING FUNCTIONS
-- ============================================================

SELECT
    name,
    UPPER(name) AS uppercase_name,
    LOWER(name) AS lowercase_name
FROM ecommerce.customers;


-- Concatenate values.

SELECT
    name || ' - ' || country AS customer_info
FROM ecommerce.customers;



-- ============================================================
-- 21. NULL CHECK
-- ============================================================

SELECT *
FROM ecommerce.customers
WHERE email IS NOT NULL;


-- Never use:
--
-- WHERE email = NULL
--
-- Use:
--
-- WHERE email IS NULL
-- WHERE email IS NOT NULL



-- ============================================================
-- 22. COMPOSITE PRIMARY KEY
-- ============================================================

-- order_items uses:
--
-- PRIMARY KEY (order_id, product_id)
--
-- Therefore this combination must be unique.

SELECT
    order_id,
    product_id,
    quantity
FROM ecommerce.order_items
ORDER BY order_id, product_id;



-- ============================================================
-- 23. CONSTRAINT / REFERENTIAL INTEGRITY
-- ============================================================

-- This should FAIL because the customer UUID
-- does not exist.

-- INSERT INTO ecommerce.orders (
--     customer_id,
--     status
-- )
-- VALUES (
--     '99999999-9999-9999-9999-999999999999',
--     'COMPLETED'
-- );


-- This should FAIL because price cannot be negative.

-- INSERT INTO ecommerce.products (
--     name,
--     category,
--     price,
--     stock_quantity
-- )
-- VALUES (
--     'Test Product',
--     'Test',
--     -10,
--     10
-- );



-- ============================================================
-- 24. COMPOSITE UNIQUE CONSTRAINT
-- ============================================================

-- products has:
--
-- UNIQUE (name, category)
--
-- Therefore this combination cannot be duplicated.

-- This should FAIL if the product already exists:

-- INSERT INTO ecommerce.products (
--     name,
--     category,
--     price,
--     stock_quantity
-- )
-- VALUES (
--     'MacBook Pro',
--     'Electronics',
--     2000,
--     10
-- );



-- ============================================================
-- 25. PRACTICAL REPORT
-- JOIN + GROUP BY + COUNT + SUM + HAVING
-- ============================================================

-- Customer sales report.

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

GROUP BY
    c.id,
    c.name,
    c.country

HAVING SUM(oi.quantity * oi.unit_price) > 500

ORDER BY total_spent DESC;



-- ============================================================
-- 26. PRACTICAL PRODUCT REPORT
-- JOIN + GROUP BY + SUM + AVG
-- ============================================================

SELECT
    p.id,
    p.name,
    p.category,

    SUM(oi.quantity) AS units_sold,

    SUM(oi.quantity * oi.unit_price) AS revenue,

    AVG(oi.unit_price) AS average_sale_price

FROM ecommerce.products p

JOIN ecommerce.order_items oi
    ON p.id = oi.product_id

JOIN ecommerce.orders o
    ON oi.order_id = o.id

WHERE o.status = 'COMPLETED'

GROUP BY
    p.id,
    p.name,
    p.category

ORDER BY revenue DESC;



-- ============================================================
-- 27. LEFT JOIN REPORT
-- Products with zero sales should also appear.
-- ============================================================

SELECT
    p.name,
    p.category,

    COALESCE(SUM(
        CASE
            WHEN o.status = 'COMPLETED'
            THEN oi.quantity
            ELSE 0
        END
    ), 0) AS units_sold

FROM ecommerce.products p

LEFT JOIN ecommerce.order_items oi
    ON p.id = oi.product_id

LEFT JOIN ecommerce.orders o
    ON oi.order_id = o.id

GROUP BY
    p.id,
    p.name,
    p.category

ORDER BY units_sold DESC;



-- ============================================================
-- 28. TOP CUSTOMERS
-- ============================================================

SELECT
    c.name,
    SUM(oi.quantity * oi.unit_price) AS total_spent

FROM ecommerce.customers c

JOIN ecommerce.orders o
    ON c.id = o.customer_id

JOIN ecommerce.order_items oi
    ON o.id = oi.order_id

WHERE o.status = 'COMPLETED'

GROUP BY
    c.id,
    c.name

ORDER BY total_spent DESC

LIMIT 5;




-- SQL execution order
-- ────────────────────────────────────────

FROM
  ↓
JOIN
  ↓
WHERE
  ↓
GROUP BY
  ↓
HAVING
  ↓
SELECT
  ↓
DISTINCT
  ↓
ORDER BY
  ↓
LIMIT


-- JOIN
-- ────────────────────────────────────────

INNER JOIN
→ only matching rows

LEFT JOIN
→ everything from left + matching right

RIGHT JOIN
→ everything from right + matching left

FULL OUTER JOIN
→ everything from both tables


-- Aggregates
-- ────────────────────────────────────────

COUNT()
SUM()
AVG()
MIN()
MAX()


-- Filtering
-- ────────────────────────────────────────

WHERE
→ filters individual rows

HAVING
→ filters grouped/aggregated results


-- Set operations
-- ────────────────────────────────────────

UNION
→ combines results + removes duplicates

UNION ALL
→ combines results + keeps duplicates


-- Useful functions
-- ────────────────────────────────────────

COALESCE()
→ replace NULL

CASE
→ conditional logic

EXTRACT()
→ extract date/time parts

UPPER()
LOWER()
→ string conversion

EXISTS
→ check whether related rows exist