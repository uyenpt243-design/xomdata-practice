-- Xom Data · Candidates not yet interviewed
-- Problem: https://xomdata.com/practice/medium-leftjoin-031
-- Solved: 2026-09-04

WITH uninterviewed AS(
    SELECT
        full_name,
        email,
        application_date,
        ROW_NUMBER() OVER(ORDER BY application_date asc, full_name asc) AS queue_position,
        ROUND(PERCENT_RANK() OVER(ORDER BY application_date asc, full_name asc)*100,2) AS older_than_pct
    FROM candidates c
    LEFT JOIN interviews i ON c.id = i.candidate_id
    WHERE i.id IS NULL
)
SELECT
    full_name, 
    email, 
    application_date,
    queue_position,
    older_than_pct
FROM uninterviewed
