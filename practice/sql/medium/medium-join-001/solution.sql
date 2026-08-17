-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-08-17

SELECT
    full_name,
    COUNT(c.id) AS order_count,
    SUM(o.total_amount) AS total_spending,
    ROUND(AVG(o.total_amount),2) AS avg_order_value,
    ROW_NUMBER() OVER (ORDER BY SUM(o.total_amount) DESC) AS spending_rank
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.full_name
