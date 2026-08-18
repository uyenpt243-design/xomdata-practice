-- Xom Data · Showtime count and average ticket price per film
-- Problem: https://xomdata.com/practice/medium-join-076
-- Solved: 2026-08-18

WITH cte AS(
    SELECT
        m.movie_name,
        m.genres,
        COUNT(s.id) AS showtime_count,
        ROUND(AVG(ticket_price),0) AS avg_ticket_price
    FROM movies m
    JOIN showtimes s ON m.id = s.movie_id
    GROUP BY m.id
)
SELECT
    movie_name,
    genres,
    showtime_count, 
    avg_ticket_price,
    DENSE_RANK() OVER(PARTITION BY genres ORDER BY avg_ticket_price desc) as rank_in_genre,
    FIRST_VALUE(movie_name) OVER(PARTITION BY  genres ORDER BY avg_ticket_price desc) AS top_movie_in_genre
FROM cte
ORDER BY genres, rank_in_genre, movie_name
