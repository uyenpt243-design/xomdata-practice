-- Xom Data · Consultation revenue by doctor
-- Problem: https://xomdata.com/practice/medium-join-141
-- Solved: 2026-08-21

with abc as(
    select
        f.id,
        d.id,
        faculty_name,
        d.full_name as doctor_name,
        COUNT(DISTINCT m.id) AS visit_count,
        avg(visit_fee) as avg_exam_fee, 
        sum(visit_fee) as total_exam_fee
    from doctors d
    join faculties f on d.faculty_id = f.id
    join medical_visits m on d.id = m.doctor_id
    group by f.id, d.id, doctor_name, f.faculty_name, full_name
)
select 
    faculty_name, 
    doctor_name,
    visit_count, 
    avg_exam_fee,
    total_exam_fee,
    RANK() OVER(ORDER BY total_exam_fee desc) as overall_rank, 
    DENSE_RANK() OVER(PARTITION BY faculty_name ORDER BY total_exam_fee desc) as rank_in_faculty
from abc
order by total_exam_fee desc, doctor_name asc
limit 15
