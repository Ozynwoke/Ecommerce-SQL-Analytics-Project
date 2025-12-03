-- CUSTOMER ORDERS WITH TOTAL AMOUNT
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount,
    o.order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;

-- ORDER ITEMS WITH PRODUCT DETAILS
SELECT
    od.order_id,
    od.product_id,
    p.product_name,
    od.quantity,
    od.price_at_purchase
FROM Order_Details od
JOIN Products p ON od.product_id = p.product_id;

-- PRODUCTS AND THEIR SUPPLIERS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    s.supplier_name,
    s.country AS supplier_country
FROM Products p
JOIN Suppliers s ON p.supplier_id = s.supplier_id;

-- INVENTORY DETAILS WITH PRODUCT INFORMATION
SELECT
    i.inventory_id,
    i.quantity_in_stock,
    i.reorder_level,
    p.product_name,
    p.category
FROM Inventory i
JOIN Products p ON i.product_id = p.product_id;

-- PAYMENTS WITH ORDER INFORMATION
SELECT
    pay.payment_id,
    pay.amount,
    pay.payment_status,
    o.order_id,
    o.customer_id
FROM Payments pay
JOIN Orders o ON pay.order_id = o.order_id;

-- CUSTOMER REVIEWS WITH PRODUCT INFORMATION
SELECT
    r.review_id,
    c.first_name,
    c.last_name,
    p.product_name,
    r.rating,
    r.comment
FROM Reviews r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Products p ON r.product_id = p.product_id;

-- RETURNS WITH ORDER AND PRODUCT DETAILS
SELECT
    ret.return_id,
    ret.reason,
    o.order_id,
    p.product_name,
    c.first_name,
    c.last_name
FROM Returns_Exchanges ret
JOIN Orders o ON ret.order_id = o.order_id
JOIN Products p ON ret.product_id = p.product_id
JOIN Customers c ON ret.customer_id = c.customer_id;
