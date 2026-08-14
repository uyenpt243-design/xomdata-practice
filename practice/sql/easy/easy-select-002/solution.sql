-- Xom Data · Get product name and price
-- Problem: https://xomdata.com/practice/easy-select-002
-- Solved: 2026-08-14

SELECT
    p.name, 
    p.price
FROM products p
ORDER BY p.name
