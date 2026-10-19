-- Xom Data · Products more expensive than the category average
-- Problem: https://xomdata.com/practice/medium-subquery-103
-- Solved: 2026-10-19

WITH average as(
    select 
        product_name, 
        category,
        price,
        avg(price) over(PARTITION BY category) as avg_price
    from products
)
SELECT
    product_name,
    category, 
    price,
    ROUND((price - avg_price),0) as diff_from_avg, 
    ROUND((price- avg_price)*100/avg_price,2) as pct_above
from average
WHERE price > avg_price
order by pct_above desc, product_name
