-- Xom Data · Average score per subject
-- Problem: https://xomdata.com/practice/medium-groupby-027
-- Solved: 2026-09-04

WITH score AS(
    SELECT
        subject_name,
        credits,
        COUNT(g.id) AS student_count, 
        ROUND(AVG(final_score),2) AS avg_score,
        ROUND(SUM(CASE WHEN final_score >= 5.0 THEN 1.0 ELSE 0.0 END)*100/ COUNT(g.id),2) as pass_rate
    FROM subjects s 
    JOIN grades g ON s.id = g.subject_id 
    GROUP BY subject_id, subject_name
)
SELECT
    subject_name, 
    credits, 
    student_count, 
    avg_score, 
    pass_rate, 
    RANK() OVER(ORDER BY avg_score desc) AS rank_by_avg,
    NTILE(4) OVER(ORDER BY avg_score desc, subject_name asc) AS difficulty_quartile
FROM score
ORDER BY rank_by_avg asc, subject_name asc
