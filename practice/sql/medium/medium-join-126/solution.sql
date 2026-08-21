-- Xom Data · Salary by department and title
-- Problem: https://xomdata.com/practice/medium-join-126
-- Solved: 2026-08-21

with abc as(
    select
    d.department_name,
    p.position_name,
    COUNT(e.id) AS employee_count,
    AVG(net_salary) AS avg_salary,
    MIN(net_salary) AS min_salary,
    MAX(net_salary) AS max_salary
    from employees e
    join positions p on e.position_id = p.id
    join departments d on d.id = e.department_id
    join payroll pa on pa.employee_id = e.id
    group by e.department_id, e.position_id
)
select
    department_name, 
    position_name,
    employee_count, 
    avg_salary,
    min_salary,
    max_salary,
    max_salary - min_salary as salary_spread, 
    RANK() OVER(PARTITION BY department_name ORDER BY avg_salary desc, position_name asc) as rank_in_dept
from abc
order by department_name, rank_in_dept, position_name
