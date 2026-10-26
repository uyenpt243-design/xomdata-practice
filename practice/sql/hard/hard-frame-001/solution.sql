-- Xom Data · 7-day moving average of revenue
-- Problem: https://xomdata.com/practice/hard-frame-001
-- Solved: 2026-10-26

with rev as(
    select
        date, 
        sum(amount) as revenue
    from daily_revenue
    group by date
)
select
    date, 
    revenue,
    round(avg(revenue) over(order by date rows between 6 preceding and current row),2) as ma7
from rev
order by date
