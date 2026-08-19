-- Xom Data · Top 10 highest-profit dishes
-- Problem: https://xomdata.com/practice/medium-agg-147
-- Solved: 2026-08-19

WITH summary AS (
    SELECT
        d.dish_name, 
        c.category_name, 
        SUM(oi.quantity) AS total_sold, 
        SUM(oi.unit_price * oi.quantity) AS revenue, 
        SUM(oi.quantity * (oi.unit_price - d.cost_price)) AS profit,
        ROUND(
            SUM((oi.unit_price - d.cost_price)*100.0/oi.unit_price),
            2
        ) AS margin_pct
    FROM order_items oi
    JOIN dishes d ON d.id = oi.dish_id
    JOIN categories c ON c.id = d.category_id
    JOIN orders o ON o.id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY d.id, d.dish_name, c.category_name
),
ranked AS (
    SELECT
        dish_name, 
        category_name, 
        total_sold, 
        revenue, 
        profit, 
        margin_pct,
        RANK() OVER (ORDER BY profit DESC) AS rank_by_profit, 
        RANK() OVER (ORDER BY margin_pct DESC) AS rank_by_margin
    FROM summary
)
SELECT 
    dish_name, 
    category_name, 
    total_sold, 
    revenue, 
    profit, 
    margin_pct, 
    rank_by_profit, 
    rank_by_margin
FROM ranked
ORDER BY 
    profit DESC, 
    dish_name ASC
LIMIT 10;
