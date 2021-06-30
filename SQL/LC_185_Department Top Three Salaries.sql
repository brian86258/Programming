/*
A company's executives are interested in seeing who earns the most money in each of the company's 
departments. A high earner in a department is an employee who has a salary in the 
top three unique salaries for that department.

Write an SQL query to find the employees who are high earners in each of the departments.
Return the result table in any order.
*/

-- create table Employee ( ID int,
-- 					    Name varchar,
-- 					    Salary int,
-- 					    DepartmentId int
-- 						);

-- create table department(ID int,
-- 						Name varchar
-- 						);

-- insert into department 
-- values
-- 	(1,'IT'),
-- 	(2,'Sales');

-- insert into Employee
-- values 
-- (1,'Joe',85000,1),
-- (2,'Henry',80000,2),
-- (3,'Sam',60000,2),
-- (4,'Max',90000,1),
-- (5,'Janet',69000,1),
-- (6,'Randy',85000,1),
-- (7,'Will',70000,1);

with rank_table as
(
	select  e.name as E_name,
			salary,
			d.name as D_name,
			DENSE_RANK()
			OVER(PARTITION BY departmentid
				 ORDER BY Salary DESC)
			as salary_rank
	from employee e
	inner join department d
	on e.DepartmentId = d.Id
)select d_name as Department,
		e_name as Employee,
		salary as Salary
from rank_table
where salary_rank <=3;