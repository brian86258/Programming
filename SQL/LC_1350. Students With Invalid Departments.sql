/*
Table: Departments
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key of this table.
Table: Students
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
| department_id | int     |
+---------------+---------+
id is the primary key of this table.

Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exists.
Return the result table in any order.
*/

/*
KEY, mysql doesn't support MINUS,EXCEPT.
Postgres version
with expire_table
as(
	select department_id from students
	EXCEPT
	select id from departments
)
select id,name from students
where department_id in (select department_id from expire_table);
*/
select s.id,s.name from students s
left join departments d on s.department_id = d.id
where d.id is null;


