-- Xom Data · Top 10 highest-paid employees and their leave days
-- Problem: https://xomdata.com/practice/medium-agg-127
-- Solved: 2026-10-26

WITH sal as(
    select
        employee_id, 
        sum(net_salary) as total_received_salary
    from payroll
    group by employee_id
),
    leave as(
    select 
        employee_id,
        count(id) as leave_count
    from leaves
    where status = 'approved'
    group by employee_id
    ),
    abc as(
    select
        e.full_name,
        e.employee_code,
        d.department_name,
        total_received_salary, 
        COALESCE(leave_count,0) as leave_count,
        avg(total_received_salary) over(PARTITION BY department_id) as avg_sal_dept
    from employees e
    left join departments d on e.department_id = d.id
    left join sal s on e.id = s.employee_id
    left join leave l on l.employee_id = e.id
    )
SELECT
    full_name,
    employee_code,
    department_name,
    total_received_salary, 
    leave_count,
    round((total_received_salary - avg_sal_dept)*100/avg_sal_dept,2) as pct_above_dept_avg
FROM abc
order by total_received_salary desc, employee_code asc
limit 10
