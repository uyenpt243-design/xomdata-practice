-- Xom Data · Stock exchanges
-- Problem: https://xomdata.com/practice/easy-distinct-007
-- Solved: 2026-08-17

select
    distinct(exchange) as exchange
from stocks
order by exchange
