-- Xom Data · Revenue pivoted by product type
-- Problem: https://xomdata.com/practice/hard-pivot-001
-- Solved: 2026-10-26

select
    Substr(sale_date,1,7) as month,
    sum(case when category = 'Electronics' then amount else 0 end) as electronics, 
    sum(Case when category = 'Clothing' then amount else 0 end) as clothing,
    sum(case when category = 'Food' then amount else 0 end) as food,
    sum(amount) as total
from sales
group by Substr(sale_date,1,7)
order by month asc
