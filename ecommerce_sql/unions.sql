-- CUSTOMER AND SUPPLIER CONTACTS
SELECT
    first_name AS name,
    email,
    phone_number,
    'Customer' AS contact_type
FROM Customers

UNION

SELECT
    supplier_name AS name,
    email,
    phone_number,
    'Supplier' AS contact_type
FROM Suppliers;


-- ORDERS WITH AND WITHOUT PROMOTIONS
SELECT
    o.order_id,
    'Promo Order' AS order_type
FROM Orders o
WHERE EXISTS (
    SELECT 1
    FROM Order_Details od
    WHERE od.order_id = o.order_id
      AND od.promo_id IS NOT NULL
)

UNION

SELECT
    o.order_id,
    'Regular Order' AS order_type
FROM Orders o
WHERE NOT EXISTS (
    SELECT 1
    FROM Order_Details od
    WHERE od.order_id = o.order_id
      AND od.promo_id IS NOT NULL
);


-- OUT OF STOCK AND LOW STOCK PRODUCTS
SELECT
    p.product_id,
    p.product_name,
    i.quantity_in_stock,
    'Out of Stock' AS stock_status
FROM Inventory i
JOIN Products p ON p.product_id = i.product_id
WHERE i.quantity_in_stock = 0

UNION

SELECT
    p.product_id,
    p.product_name,
    i.quantity_in_stock,
    'Low Stock' AS stock_status
FROM Inventory i
JOIN Products p ON p.product_id = i.product_id
WHERE i.quantity_in_stock BETWEEN 1 AND i.reorder_level;


-- POSITIVE AND NEGATIVE REVIEWS
SELECT
    r.product_id,
    r.rating,
    'Positive Review' AS review_type
FROM Reviews r
WHERE r.rating >= 4

UNION

SELECT
    r.product_id,
    r.rating,
    'Negative Review' AS review_type
FROM Reviews r
WHERE r.rating <= 2;


-- PAYMENT STATUS GROUPING
SELECT
    payment_id,
    'Successful' AS payment_group
FROM Payments
WHERE payment_status = 'Completed'

UNION

SELECT
    payment_id,
    'Unsuccessful' AS payment_group
FROM Payments
WHERE payment_status IN ('Pending', 'Failed');


-- RETURNED OR EXCHANGED PRODUCTS
SELECT
    product_id,
    'Returned' AS status
FROM Returns_Exchanges

UNION

SELECT
    exchange_product_id AS product_id,
    'Exchanged' AS status
FROM Returns_Exchanges
WHERE exchange_product_id IS NOT NULL;
