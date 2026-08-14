-- Xom Data · Store list by city
-- Problem: https://xomdata.com/practice/easy-select-005
-- Solved: 2026-08-14

SELECT 
    s.name, 
    s.city
FROM stores s
ORDER BY s.city, s.name
