
-----------------------------------------------------------22/09/2020
----------------------------------------Question 2 Answer-----------------------------------------------------------

select d.department_name,e.employee_id ,e.first_name|| ' '  || e.last_name as Oldest_emp_name, e.hire_date from hr.employees e ,hr.departments d
where e.department_id = d.department_id 
and 
e.hire_date in   (
select doj from (select min(hire_date) as doj ,department_id
from hr.employees
group by department_id)
)
--------------------------------------------------------------------------------------------------------------------