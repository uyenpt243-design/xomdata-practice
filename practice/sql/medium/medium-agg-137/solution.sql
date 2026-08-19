-- Xom Data · Investor trade summary
-- Problem: https://xomdata.com/practice/medium-agg-137
-- Solved: 2026-08-19

with sellbuy as(
  select
    investor_id,
    full_name,
    segment,
    COUNT(investor_id) AS total_trades,
    sum(case when side = 'buy' then amount else 0 end) as total_bought,
    sum(case when side = 'sell' then amount else 0 end) as total_sold
  from investors i
  join trades t on t.investor_id = i.id
  group by i.id, full_name, segment
)
select
  full_name,
  segment,
  total_trades,
  total_bought,
  total_sold,
  total_bought - total_sold as net_position,
  CASE WHEN total_bought > total_sold THEN 'Bull'
      WHEN total_bought < total_sold THEN 'Bear' ELSE 'Neutral' END as stance,
  DENSE_RANK() OVER(PARTITION BY segment ORDER BY total_bought + total_sold desc) AS rank_in_segment
from sellbuy
order by total_bought + total_sold desc, full_name
