-- CUSTOMERS WITH ABOVE-AVERAGE TOTAL SPENDING
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) >
       (SELECT AVG(total_amount) FROM Orders);

-- PRODUCTS PRICED ABOVE CATEGORY AVERAGE
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.price
FROM Products p
WHERE p.price > (
    SELECT AVG(price)
    FROM Products
    WHERE category = p.category
);

-- SUPPLIERS WITH MORE PRODUCTS THAN THE AVERAGE SUPPLIER
SELECT
    s.supplier_id,
    s.supplier_name,
    COUNT(p.product_id) AS product_count
FROM Suppliers s
JOIN Products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name
HAVING COUNT(p.product_id) > (
    SELECT AVG(product_count)
    FROM (
        SELECT COUNT(product_id) AS product_count
        FROM Products
        GROUP BY supplier_id
    ) AS t
);

-- ORDERS ABOVE THE CUSTOMER'S AVERAGE ORDER VALUE
SELECT
    o.order_id,
    o.customer_id,
    o.total_amount
FROM Orders o
WHERE o.total_amount > (
    SELECT AVG(o2.total_amount)
    FROM Orders o2
    WHERE o2.customer_id = o.customer_id
);

-- PRODUCTS WITH BELOW-AVERAGE STOCK LEVEL
SELECT
    p.product_id,
    p.product_name,
    i.quantity_in_stock
FROM Products p
JOIN Inventory i ON p.product_id = i.product_id
WHERE i.quantity_in_stock < (
    SELECT AVG(quantity_in_stock)
    FROM Inventory
);

-- ORDERS THAT USED PROMOTIONS
SELECT
    od.order_id,
    od.product_id,
    od.promo_id
FROM Order_Details od
WHERE od.promo_id IS NOT NULL;

-- CUSTOMERS WITH NO ORDERS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
);
