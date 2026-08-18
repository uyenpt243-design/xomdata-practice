-- Xom Data · Instructor teaching load
-- Problem: https://xomdata.com/practice/medium-join-029
-- Solved: 2026-08-18

WITH cte AS(
    SELECT
        l.full_name,
        l.academic_degree,
        COUNT(DISTINCT s.id) AS subjects_taught
    FROM lecturers l
    JOIN subjects s ON l.id = s.lecturer_id 
    GROUP BY s.lecturer_id)
SELECT
    full_name,
    academic_degree, 
    subjects_taught, 
    RANK() OVER(ORDER BY subjects_taught DESC) as workload_rank,
    SUM(subjects_taught) OVER(ORDER BY subjects_taught desc, full_name) as cumulative_subjects
FROM cte
