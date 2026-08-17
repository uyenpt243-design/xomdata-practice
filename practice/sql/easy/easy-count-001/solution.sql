-- Xom Data · Total products in the catalog
-- Problem: https://xomdata.com/practice/easy-count-001
-- Solved: 2026-08-17

SELECT
    COUNT(DISTINCT id) AS total_products
FROM products
