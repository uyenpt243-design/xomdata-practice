-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-10-19

with score as(
    select
        full_name, 
        student_code,
        round(avg(final_score),2) as avg_score
    from students st
    join scores sc on st.id = sc.student_id
    group by student_code, full_name
)
    select
        full_name, 
        student_code,
        avg_score,
        CASE
            WHEN avg_score >= 9 THEN 'Excellent'
            WHEN avg_score BETWEEN 8 AND 9 THEN 'Good'
            WHEN avg_score BETWEEN 7 AND 8 THEN 'Fair'
            WHEN avg_score BETWEEN 5 AND 7 THEN 'Average' ELSE 'Poor' END as grade,
        DENSE_RANK() over(order by avg_score desc) as class_rank
    from score
    order by avg_score desc, student_code asc
    limit 20;
