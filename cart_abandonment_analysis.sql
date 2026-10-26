-- Create the customer table
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_segment VARCHAR(20),
    device_type VARCHAR(20),
    acquisition_channel VARCHAR(30),
    region VARCHAR(20),
    age_group VARCHAR(10),
    loyalty_member VARCHAR(5)
);

-- Create the sessions table
CREATE TABLE sessions (
    session_id VARCHAR(12) PRIMARY KEY,
    customer_id VARCHAR(10),
    session_date DATE,
    product_category VARCHAR(30),
    cart_value_inr NUMERIC(10,2),
    items_in_cart INT,
    discount_percent INT,
    shipping_cost_type VARCHAR(10),
    checkout_started VARCHAR(5),
    payment_method VARCHAR(30),
    checkout_duration_minutes NUMERIC(5,1),
    page_views INT,
    session_outcome VARCHAR(15),
    abandonment_reason VARCHAR(40),

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- Verify imported data
SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_sessions
FROM sessions;

-- Check that the IDs are unique. The counts should match within each table.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM customers;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT session_id) AS unique_sessions
FROM sessions;

-- Check missing values
SELECT
    COUNT(*) FILTER (
        WHERE customer_id IS NULL
    ) AS missing_customer_id,
    COUNT(*) FILTER (
        WHERE session_date IS NULL
    ) AS missing_session_date,
    COUNT(*) FILTER (
        WHERE cart_value_inr IS NULL
    ) AS missing_cart_value,
    COUNT(*) FILTER (
        WHERE session_outcome IS NULL
    ) AS missing_session_outcome
FROM sessions;

-- Check invalid values
SELECT * FROM sessions 
   WHERE cart_value_inr < 0
   OR items_in_cart <= 0
   OR discount_percent NOT BETWEEN 0 AND 100
   OR session_outcome NOT IN ('Abandoned', 'Converted');

-- Check for customer IDs without a matching customer
SELECT COUNT(*) AS unmatched_customer_sessions
FROM sessions s
LEFT JOIN customers c
    ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Check whether session outcomes have valid reasons
SELECT session_outcome, abandonment_reason, COUNT(*) AS session_count
FROM sessions
GROUP BY session_outcome, abandonment_reason
ORDER BY session_outcome, session_count DESC;

-- Join the two tables
SELECT s.session_id, s.customer_id, s.session_date, c.customer_segment, c.device_type, c.acquisition_channel,
    c.region, c.loyalty_member, s.product_category, s.cart_value_inr, s.items_in_cart, s.discount_percent,
    s.shipping_cost_type, s.checkout_started, s.payment_method, s.session_outcome, s.abandonment_reason
FROM sessions s
INNER JOIN customers c
    ON s.customer_id = c.customer_id
LIMIT 20;


-- Answer the business questions from BRD

-- Business question 1: What is the overall abandonment rate?
SELECT
    COUNT(*) AS total_sessions,
    COUNT(*) FILTER (
        WHERE session_outcome = 'Abandoned'
    ) AS abandoned_sessions,
    COUNT(*) FILTER (
        WHERE session_outcome = 'Converted'
    ) AS converted_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE session_outcome = 'Abandoned'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS abandonment_rate_percent
FROM sessions;

-- Business question 2: Which devices have the highest abandonment rate?
SELECT
    c.device_type,
    COUNT(*) AS total_sessions,
    COUNT(*) FILTER (
        WHERE s.session_outcome = 'Abandoned'
    ) AS abandoned_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE s.session_outcome = 'Abandoned'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS abandonment_rate_percent
FROM sessions s
JOIN customers c
    ON s.customer_id = c.customer_id
GROUP BY c.device_type
ORDER BY abandonment_rate_percent DESC;

-- Business question 3: Which product categories show more abandonment?
SELECT
    product_category,
    COUNT(*) AS total_sessions,
    COUNT(*) FILTER (
        WHERE session_outcome = 'Abandoned'
    ) AS abandoned_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE session_outcome = 'Abandoned'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS abandonment_rate_percent
FROM sessions
GROUP BY product_category
ORDER BY abandonment_rate_percent DESC;

-- Business question 4: Is paid shipping associated with abandonment?
SELECT
    shipping_cost_type,
    COUNT(*) AS total_sessions,
    COUNT(*) FILTER (
        WHERE session_outcome = 'Abandoned'
    ) AS abandoned_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE session_outcome = 'Abandoned'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS abandonment_rate_percent
FROM sessions
GROUP BY shipping_cost_type
ORDER BY abandonment_rate_percent DESC;

-- Business question 5: Which payment methods have higher abandonment rates?
SELECT
    payment_method,
    COUNT(*) AS total_sessions,
    COUNT(*) FILTER (
        WHERE session_outcome = 'Abandoned'
    ) AS abandoned_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE session_outcome = 'Abandoned'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS abandonment_rate_percent
FROM sessions
GROUP BY payment_method
ORDER BY abandonment_rate_percent DESC;

-- Business question 6: Which abandonment reasons occur most often?
SELECT
    abandonment_reason,
    COUNT(*) AS abandoned_sessions,
    ROUND(
        100.0 * COUNT(*) /
        NULLIF(SUM(COUNT(*)) OVER (), 0),
        2
    ) AS percentage_of_abandoned_sessions
FROM sessions
WHERE session_outcome = 'Abandoned'
GROUP BY abandonment_reason
ORDER BY abandoned_sessions DESC;

-- Business question 7: How do customer segments compare?
SELECT
    c.customer_segment,
    COUNT(*) AS total_sessions,
    COUNT(*) FILTER (
        WHERE s.session_outcome = 'Abandoned'
    ) AS abandoned_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE s.session_outcome = 'Abandoned'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS abandonment_rate_percent
FROM sessions s
JOIN customers c
    ON s.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY abandonment_rate_percent DESC;

-- Business question 8: How does abandonment change month by month?
SELECT
    DATE_TRUNC('month', session_date)::DATE AS month_start,
    COUNT(*) AS total_sessions,
    COUNT(*) FILTER (
        WHERE session_outcome = 'Abandoned'
    ) AS abandoned_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE session_outcome = 'Abandoned'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS abandonment_rate_percent
FROM sessions
GROUP BY DATE_TRUNC('month', session_date)
ORDER BY month_start;

-- Business question 9: Does abandonment vary by discount?
SELECT
    discount_percent,
    COUNT(*) AS total_sessions,
    COUNT(*) FILTER (
        WHERE session_outcome = 'Abandoned'
    ) AS abandoned_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE session_outcome = 'Abandoned'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS abandonment_rate_percent
FROM sessions
GROUP BY discount_percent
ORDER BY discount_percent;

-- Business question 10: What is the relationship between cart value and abandonment?
SELECT
    CASE
        WHEN cart_value_inr < 1000 THEN 'Under ₹1,000'
        WHEN cart_value_inr < 3000 THEN '₹1,000–₹2,999'
        WHEN cart_value_inr < 5000 THEN '₹3,000–₹4,999'
        WHEN cart_value_inr < 10000 THEN '₹5,000–₹9,999'
        ELSE '₹10,000 and above'
    END AS cart_value_band,
    COUNT(*) AS total_sessions,
    COUNT(*) FILTER (
        WHERE session_outcome = 'Abandoned'
    ) AS abandoned_sessions,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE session_outcome = 'Abandoned'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS abandonment_rate_percent
FROM sessions
GROUP BY 1
ORDER BY MIN(cart_value_inr);










