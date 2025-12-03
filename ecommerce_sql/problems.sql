-- PROBLEM 1: Top 5 customers by total spending
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;


-- PROBLEM 2: Products with the highest return rate
SELECT
    p.product_id,
    p.product_name,
    COUNT(r.return_id) AS return_count
FROM Products p
JOIN Returns_Exchanges r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY return_count DESC
LIMIT 5;


-- PROBLEM 3: Suppliers with above-average product pricing
SELECT
    s.supplier_id,
    s.supplier_name,
    AVG(p.price) AS avg_price
FROM Suppliers s
JOIN Products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name
HAVING AVG(p.price) >
       (SELECT AVG(price) FROM Products)
ORDER BY avg_price DESC;


-- PROBLEM 4: Most profitable product (revenue minus product returns)
SELECT
    p.product_id,
    p.product_name,
    SUM(od.price_at_purchase * od.quantity) AS revenue,
    COALESCE(SUM(r.refund_amount), 0) AS refunds,
    SUM(od.price_at_purchase * od.quantity)
      - COALESCE(SUM(r.refund_amount), 0) AS net_profit
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
LEFT JOIN Returns_Exchanges r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY net_profit DESC
LIMIT 1;


-- PROBLEM 5: Customers who frequently return items
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.return_id) AS return_count
FROM Customers c
JOIN Returns_Exchanges r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.return_id) > 2
ORDER BY return_count DESC;


-- PROBLEM 6: Products that consistently receive low inventory levels
SELECT
    p.product_id,
    p.product_name,
    AVG(i.quantity_in_stock) AS avg_stock
FROM Products p
JOIN Inventory i ON p.product_id = i.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(i.quantity_in_stock) < 10
ORDER BY avg_stock ASC;


-- PROBLEM 7: Highest-rated products (minimum 10 reviews)
SELECT
    p.product_id,
    p.product_name,
    AVG(r.rating) AS avg_rating,
    COUNT(r.review_id) AS review_count
FROM Products p
JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(r.review_id) >= 10
ORDER BY avg_rating DESC;


-- PROBLEM 8: Customers with the highest lifetime value (LTV)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS lifetime_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY lifetime_value DESC
LIMIT 3;
