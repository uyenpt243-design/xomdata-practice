-- Xom Data · Summary of issues to handle
-- Problem: https://xomdata.com/practice/medium-union-175
-- Solved: 2026-10-20

with abc as(
    select
        'Complaint' as type,
        count(id) as quantity
    from complaints
    where status = 'Pending'
    UNION ALL
    select
        'Cancelled Order' as type,
        count(id) as quantity
    from orders
    where status = 'Cancelled'
    UNION ALL
    select      
        'Out of Stock Product' as type, 
        count(id) as quantity
    from products
    where status = 'Out of Stock'
),
bcd as(
SELECT
    type, 
    quantity,
    round((quantity*100/ nullif(sum(quantity) over(),0)),2) as pct_of_total,
    rank() over(order by quantity desc) as rank_pos
FROM abc)
SELECT
    type, 
    quantity, 
    pct_of_total,
    rank_pos,
    round(SUM(quantity)OVER(order by quantity desc, type)*100.0/nullif(sum(quantity)OVER(),0),2) as cumulative_pct
from bcd
order by rank_pos, type
