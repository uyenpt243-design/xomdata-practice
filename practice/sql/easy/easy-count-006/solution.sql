-- Xom Data · Total number of bank accounts
-- Problem: https://xomdata.com/practice/easy-count-006
-- Solved: 2026-08-17

select
    count(distinct id) as total_accounts
from accounts
