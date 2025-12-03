-- CUSTOMER LOCATION CATEGORY
SELECT
    customer_id,
    first_name,
    last_name,
    country,
    CASE
        WHEN country IN ('United States', 'Canada') THEN 'North America'
        WHEN country IN ('United Kingdom', 'Germany', 'France') THEN 'Europe'
        ELSE 'Other'
    END AS region_category
FROM Customers;

-- ORDER VALUE CLASSIFICATION
SELECT
    order_id,
    total_amount,
    CASE
        WHEN total_amount < 50 THEN 'Low Value'
        WHEN total_amount BETWEEN 50 AND 200 THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_value_category
FROM Orders;

-- PRODUCT PRICING CATEGORY
SELECT
    product_id,
    product_name,
    price,
    CASE
        WHEN price < 20 THEN 'Budget'
        WHEN price BETWEEN 20 AND 100 THEN 'Standard'
        ELSE 'Premium'
    END AS price_category
FROM Products;

-- INVENTORY RISK LEVEL
SELECT
    inventory_id,
    product_id,
    quantity_in_stock,
    reorder_level,
    CASE
        WHEN quantity_in_stock = 0 THEN 'Out of Stock'
        WHEN quantity_in_stock <= reorder_level THEN 'Low Stock'
        ELSE 'Healthy Stock'
    END AS stock_status
FROM Inventory;

-- PAYMENT STATUS GROUPING
SELECT
    payment_id,
    amount,
    payment_status,
    CASE
        WHEN payment_status = 'Pending' THEN 'Awaiting Confirmation'
        WHEN payment_status = 'Completed' THEN 'Paid'
        WHEN payment_status = 'Failed' THEN 'Issue'
        ELSE 'Unknown'
    END AS payment_category
FROM Payments;

-- REVIEW SENTIMENT CATEGORY
SELECT
    review_id,
    rating,
    CASE
        WHEN rating IN (4, 5) THEN 'Positive'
        WHEN rating = 3 THEN 'Neutral'
        ELSE 'Negative'
    END AS review_sentiment
FROM Reviews;

-- PROMOTION TYPE DESCRIPTION
SELECT
    promo_id,
    promo_code,
    discount_type,
    discount_value,
    CASE
        WHEN discount_type = 'Percentage' THEN discount_value || '% Off'
        WHEN discount_type = 'Fixed' THEN '₦' || discount_value || ' Off'
        ELSE 'Unknown'
    END AS promo_description
FROM Promotions;
