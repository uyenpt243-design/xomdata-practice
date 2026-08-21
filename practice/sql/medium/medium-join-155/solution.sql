-- Xom Data · Rank hotels by room price within each destination
-- Problem: https://xomdata.com/practice/medium-join-155
-- Solved: 2026-08-21

with abc as(
    select
        h.hotel_name,
        h.star_class,
        d.destination_name,
        COUNT(distinct r.id) as room_count, 
        min(nightly_rate) as min_price, 
        max(nightly_rate) as max_price, 
        avg(nightly_rate) as avg_price
    from hotels h
    join destinations d on h.destination_id = d.id
    join hotel_rooms r on r.hotel_id = h.id
    group by h.id, d.id, h.star_class, d.destination_name
    having COUNT(distinct r.id) >= 2
)
select
    hotel_name, 
    star_class,
    destination_name,
    room_count, 
    min_price, 
    max_price, 
    avg_price, 
    max_price - min_price as price_spread, 
    RANK() OVER(PARTITION BY destination_name ORDER BY avg_price desc) as rank_in_destination
from abc
order by destination_name asc, rank_in_destination asc, hotel_name asc
