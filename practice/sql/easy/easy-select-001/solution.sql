-- Xom Data · View the full product catalog
-- Problem: https://xomdata.com/practice/easy-select-001
-- Solved: 2026-08-14

SELECT
    p.id,
    p.name,
    p.price,
    p.categories,
    p.quantity
FROM products p
ORDER BY p.id
