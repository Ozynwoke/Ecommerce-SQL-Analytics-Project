-- ORDERS BY MONTH
SELECT
    DATE_TRUNC('month', order_date) AS order_month,
    COUNT(*) AS total_orders
FROM Orders
GROUP BY order_month
ORDER BY order_month;

-- NEW CUSTOMERS BY YEAR
SELECT
    EXTRACT(YEAR FROM created_at) AS customer_year,
    COUNT(*) AS new_customers
FROM Customers
GROUP BY customer_year
ORDER BY customer_year;

-- DAILY SALES TOTALS
SELECT
    CAST(order_date AS DATE) AS order_day,
    SUM(total_amount) AS daily_sales
FROM Orders
GROUP BY order_day
ORDER BY order_day;

-- AVERAGE ORDER VALUE BY MONTH
SELECT
    DATE_TRUNC('month', order_date) AS order_month,
    AVG(total_amount) AS average_order_value
FROM Orders
GROUP BY order_month
ORDER BY order_month;

-- PRODUCT PRICE HISTORY (CREATED AT)
SELECT
    product_name,
    created_at AS date_added,
    price
FROM Products
ORDER BY created_at;

-- CUSTOMER ACTIVITY WINDOW (FIRST AND LAST ORDER)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    MIN(o.order_date) AS first_order_date,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY last_order_date DESC;

-- ACTIVE PROMOTIONS BY DATE
SELECT
    promo_id,
    promo_code,
    start_date,
    end_date
FROM Promotions
WHERE CURRENT_DATE BETWEEN start_date AND end_date;
