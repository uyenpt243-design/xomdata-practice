-- Xom Data · Top 3 products by sales in each category
-- Problem: https://xomdata.com/practice/hard-topn-001
-- Solved: 2026-10-26

with abc as(select
    category,
    name as product_name,
    sum(units_sold) as units_sold,
    DENSE_RANK() over(PARTITION BY category order by sum(units_sold) desc) as rank_in_cat
from products
group by name, category)
select
    category, 
    product_name,
    units_sold,
    rank_in_cat
from abc
where rank_in_cat <=3
order by category asc, rank_in_cat asc, product_name asc
