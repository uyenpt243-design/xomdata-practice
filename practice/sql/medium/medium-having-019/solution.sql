-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-10-19

with abc as(
    select 
        store_name,
        reputation_score,
        count(o.id) as order_count,
        DENSE_RANK() over(order by count (o.id) desc) as rank_by_orders
    from sellers s
    join orders o on s.id = o.seller_id
    where reputation_score >= 4.5
    group by store_name, reputation_score
    having count(o.id) >= 3
)
Select
    store_name, 
    reputation_score,
    order_count, 
    rank_by_orders,
    SUM(order_count) OVER(ORDER BY order_count desc, STORE_NAME asc) as cumulative_orders
From abc
order by rank_by_orders asc, store_name asc
