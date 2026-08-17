-- Xom Data · Number of delivered orders
-- Problem: https://xomdata.com/practice/easy-count-002
-- Solved: 2026-08-17

SELECT
    COUNT(DISTINCT id) AS order_count
FROM orders
WHERE status = 'Delivered'
