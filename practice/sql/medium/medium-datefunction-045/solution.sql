-- Xom Data · Transaction count and amount by month
-- Problem: https://xomdata.com/practice/medium-datefunction-045
-- Solved: 2026-10-20

with abc as(
    select
        SUBSTR(transaction_date, 1, 7) as month, 
        count(id) as transaction_count,
        sum(amount) as total_amount
    from transactions
    group by SUBSTR(transaction_date, 1, 7)
)
select
    month, 
    transaction_count,
    total_amount,
    total_amount - lag(total_amount) over (order by month asc) as mom_delta
from abc
order by month
