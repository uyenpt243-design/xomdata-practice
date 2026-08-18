-- Xom Data · Stock-in history by supplier
-- Problem: https://xomdata.com/practice/medium-join-014
-- Solved: 2026-08-18

SELECT
    w.warehouse_name,
    COUNT(s.id) AS import_count,
    COUNT(DISTINCT s.product_id) AS distinct_product_count,
    COUNT(DISTINCT s.suppliers) AS distinct_supplier_count,
    MAX(s.import_date) AS last_import_date,
    RANK() OVER(ORDER BY COUNT(s.id) desc) AS activity_rank,
    LAG(w.warehouse_name) OVER(ORDER BY COUNT(s.id) desc, w.warehouse_name) AS prev_warehouse
FROM stock_imports s
JOIN products p ON s.product_id = p.id
JOIN warehouses w ON w.id = s.warehouse_id 
GROUP BY w.id, w.warehouse_name
