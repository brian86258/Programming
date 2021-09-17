/*
select extract(day from visit_date) from visits;
Employees can belong to multiple departments.
When the employee joins other departments, they need to decide which department is their primary department. 
Note that when an employee belongs to only one department, their primary column is 'N'.

Write an SQL query to report all the employees with their primary department. 
For employees who belong to one department, report their only department.

Return the result table in any order.

The query result format is in the following example.
*/
with helper_table
as(
	select 	*,
			COUNT(primary_flag)
			OVER(Partition by employee_id)
			as dep_count
	from employee
)
select employee_id, department_id
from helper_table
where primary_flag = 'Y' or ( primary_flag = 'N' and dep_count =1);