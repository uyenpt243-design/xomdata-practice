-- Xom Data · Book count and average price by genre
-- Problem: https://xomdata.com/practice/medium-coalesce-040
-- Solved: 2026-10-19

with abc as(
    select
        genre_name, 
        count(b.id) as book_count,
        COALESCE(round((avg(price)),0),0) as avg_price,
        COALESCE(min(price),0) as min_price,
        COALESCE(max(price),0) as max_price
    from genres g
    LEFT join books b on g.id = b.genre_id
    group by genre_name
)
SELECT
    genre_name,
    book_count,
    avg_price,
    min_price,
    max_price,
    max_price - min_price as price_range, 
    rank() over(order by book_count desc) as coverage_rank,
    NTILE(3) over(order by book_count desc, genre_name asc) as library_focus
from abc
order by coverage_rank asc, genre_name
