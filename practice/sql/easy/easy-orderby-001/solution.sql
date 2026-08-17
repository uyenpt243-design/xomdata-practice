-- Xom Data · Active menu sorted by price
-- Problem: https://xomdata.com/practice/easy-orderby-001
-- Solved: 2026-08-17

select
dish_name, 
price
from menu
where status = 'Active'
order by price ASC, dish_name ASC
