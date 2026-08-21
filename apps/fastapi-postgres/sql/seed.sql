-- ============================================================
-- Seed data for ecommerce schema
-- ============================================================


-- ============================================================
-- CUSTOMERS
-- ============================================================

INSERT INTO ecommerce.customers (
    id,
    name,
    email,
    country
)
VALUES
    (
        '11111111-1111-1111-1111-111111111111',
        'Alice Johnson',
        'alice.johnson@example.com',
        'USA'
    ),
    (
        '22222222-2222-2222-2222-222222222222',
        'Bob Smith',
        'bob.smith@example.com',
        'Canada'
    ),
    (
        '33333333-3333-3333-3333-333333333333',
        'Charlie Brown',
        'charlie.brown@example.com',
        'USA'
    ),
    (
        '44444444-4444-4444-4444-444444444444',
        'David Wilson',
        'david.wilson@example.com',
        'UK'
    ),
    (
        '55555555-5555-5555-5555-555555555555',
        'Emma Davis',
        'emma.davis@example.com',
        'USA'
    ),
    (
        '66666666-6666-6666-6666-666666666666',
        'Frank Miller',
        'frank.miller@example.com',
        'Germany'
    ),
    (
        '77777777-7777-7777-7777-777777777777',
        'Grace Lee',
        'grace.lee@example.com',
        'South Korea'
    ),
    (
        '88888888-8888-8888-8888-888888888888',
        'Henry Taylor',
        'henry.taylor@example.com',
        'Australia'
    );


-- ============================================================
-- PRODUCTS
-- ============================================================

INSERT INTO ecommerce.products (
    id,
    name,
    category,
    price,
    stock_quantity
)
VALUES
    (
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        'MacBook Pro',
        'Electronics',
        1999.00,
        15
    ),
    (
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        'Mechanical Keyboard',
        'Electronics',
        120.00,
        50
    ),
    (
        'cccccccc-cccc-cccc-cccc-cccccccccccc',
        'Wireless Mouse',
        'Electronics',
        60.00,
        100
    ),
    (
        'dddddddd-dddd-dddd-dddd-dddddddddddd',
        '4K Monitor',
        'Electronics',
        450.00,
        30
    ),
    (
        'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
        'Standing Desk',
        'Furniture',
        550.00,
        20
    ),
    (
        'ffffffff-ffff-ffff-ffff-ffffffffffff',
        'Office Chair',
        'Furniture',
        350.00,
        25
    ),
    (
        'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',
        'Desk Lamp',
        'Furniture',
        80.00,
        75
    ),
    (
        'bbbbbbbb-cccc-dddd-eeee-ffffffffffff',
        'USB-C Hub',
        'Accessories',
        90.00,
        60
    ),
    (
        'cccccccc-dddd-eeee-ffff-aaaaaaaaaaaa',
        'Laptop Stand',
        'Accessories',
        110.00,
        40
    ),
    (
        'dddddddd-eeee-ffff-aaaa-bbbbbbbbbbbb',
        'Webcam',
        'Accessories',
        140.00,
        45
    ),
    (
        'eeeeeeee-ffff-aaaa-bbbb-cccccccccccc',
        'Noise Cancelling Headphones',
        'Audio',
        300.00,
        35
    ),
    (
        'ffffffff-aaaa-bbbb-cccc-dddddddddddd',
        'Bluetooth Speaker',
        'Audio',
        180.00,
        40
    );


-- ============================================================
-- ORDERS
-- ============================================================

INSERT INTO ecommerce.orders (
    id,
    customer_id,
    status,
    order_date
)
VALUES
    (
        '10000000-0000-0000-0000-000000000001',
        '11111111-1111-1111-1111-111111111111',
        'COMPLETED',
        '2026-08-01 10:30:00'
    ),
    (
        '10000000-0000-0000-0000-000000000002',
        '11111111-1111-1111-1111-111111111111',
        'COMPLETED',
        '2026-08-05 14:15:00'
    ),
    (
        '10000000-0000-0000-0000-000000000003',
        '22222222-2222-2222-2222-222222222222',
        'COMPLETED',
        '2026-08-03 09:45:00'
    ),
    (
        '10000000-0000-0000-0000-000000000004',
        '33333333-3333-3333-3333-333333333333',
        'PENDING',
        '2026-08-06 16:20:00'
    ),
    (
        '10000000-0000-0000-0000-000000000005',
        '44444444-4444-4444-4444-444444444444',
        'COMPLETED',
        '2026-08-07 11:10:00'
    ),
    (
        '10000000-0000-0000-0000-000000000006',
        '55555555-5555-5555-5555-555555555555',
        'CANCELLED',
        '2026-08-08 13:30:00'
    ),
    (
        '10000000-0000-0000-0000-000000000007',
        '66666666-6666-6666-6666-666666666666',
        'COMPLETED',
        '2026-08-09 15:00:00'
    ),
    (
        '10000000-0000-0000-0000-000000000008',
        '77777777-7777-7777-7777-777777777777',
        'COMPLETED',
        '2026-08-10 12:45:00'
    ),
    (
        '10000000-0000-0000-0000-000000000009',
        '22222222-2222-2222-2222-222222222222',
        'PENDING',
        '2026-08-11 10:00:00'
    ),
    (
        '10000000-0000-0000-0000-000000000010',
        '33333333-3333-3333-3333-333333333333',
        'COMPLETED',
        '2026-08-12 17:30:00'
    ),
    (
        '10000000-0000-0000-0000-000000000011',
        '44444444-4444-4444-4444-444444444444',
        'COMPLETED',
        '2026-08-13 09:20:00'
    );


-- ============================================================
-- ORDER ITEMS
-- Composite Primary Key:
--     (order_id, product_id)
-- ============================================================

INSERT INTO ecommerce.order_items (
    order_id,
    product_id,
    quantity,
    unit_price
)
VALUES

    -- Alice - Order 1
    (
        '10000000-0000-0000-0000-000000000001',
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        1,
        1999.00
    ),
    (
        '10000000-0000-0000-0000-000000000001',
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        1,
        120.00
    ),
    (
        '10000000-0000-0000-0000-000000000001',
        'cccccccc-cccc-cccc-cccc-cccccccccccc',
        2,
        60.00
    ),

    -- Alice - Order 2
    (
        '10000000-0000-0000-0000-000000000002',
        'dddddddd-dddd-dddd-dddd-dddddddddddd',
        1,
        450.00
    ),
    (
        '10000000-0000-0000-0000-000000000002',
        'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
        1,
        550.00
    ),

    -- Bob - Order 3
    (
        '10000000-0000-0000-0000-000000000003',
        'ffffffff-ffff-ffff-ffff-ffffffffffff',
        1,
        350.00
    ),
    (
        '10000000-0000-0000-0000-000000000003',
        'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',
        2,
        80.00
    ),

    -- Charlie - Order 4 (PENDING)
    (
        '10000000-0000-0000-0000-000000000004',
        'bbbbbbbb-cccc-dddd-eeee-ffffffffffff',
        1,
        90.00
    ),
    (
        '10000000-0000-0000-0000-000000000004',
        'cccccccc-dddd-eeee-ffff-aaaaaaaaaaaa',
        1,
        110.00
    ),

    -- David - Order 5
    (
        '10000000-0000-0000-0000-000000000005',
        'eeeeeeee-ffff-aaaa-bbbb-cccccccccccc',
        1,
        300.00
    ),
    (
        '10000000-0000-0000-0000-000000000005',
        'ffffffff-aaaa-bbbb-cccc-dddddddddddd',
        1,
        180.00
    ),

    -- Emma - Order 6 (CANCELLED)
    (
        '10000000-0000-0000-0000-000000000006',
        'dddddddd-eeee-ffff-aaaa-bbbbbbbbbbbb',
        2,
        140.00
    ),

    -- Frank - Order 7
    (
        '10000000-0000-0000-0000-000000000007',
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        1,
        1999.00
    ),
    (
        '10000000-0000-0000-0000-000000000007',
        'eeeeeeee-ffff-aaaa-bbbb-cccccccccccc',
        1,
        300.00
    ),
    (
        '10000000-0000-0000-0000-000000000007',
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        2,
        120.00
    ),

    -- Grace - Order 8
    (
        '10000000-0000-0000-0000-000000000008',
        'dddddddd-dddd-dddd-dddd-dddddddddddd',
        2,
        450.00
    ),
    (
        '10000000-0000-0000-0000-000000000008',
        'dddddddd-eeee-ffff-aaaa-bbbbbbbbbbbb',
        1,
        140.00
    ),

    -- Bob - Order 9 (PENDING)
    (
        '10000000-0000-0000-0000-000000000009',
        'ffffffff-aaaa-bbbb-cccc-dddddddddddd',
        1,
        180.00
    ),

    -- Charlie - Order 10
    (
        '10000000-0000-0000-0000-000000000010',
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        1,
        120.00
    ),
    (
        '10000000-0000-0000-0000-000000000010',
        'cccccccc-cccc-cccc-cccc-cccccccccccc',
        3,
        60.00
    ),

    -- David - Order 11
    (
        '10000000-0000-0000-0000-000000000011',
        'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
        1,
        550.00
    ),
    (
        '10000000-0000-0000-0000-000000000011',
        'ffffffff-ffff-ffff-ffff-ffffffffffff',
        1,
        350.00
    );