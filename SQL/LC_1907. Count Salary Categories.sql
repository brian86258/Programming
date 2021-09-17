/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key for this table.
Each row contains information about the monthly income for one bank account.
 

Write an SQL query to report the number of bank accounts of each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, then report 0. Return the result table in any order.

The query result format is in the following example.
*/

with helper_low
as(
	select 'Low Salary' as category, count(*) as accounts_count  from accounts
	where income < 20000
), helper_avg
as(
	select 'Average Salary' as category, count(*) as accounts_count from accounts	
	where 20000 <= income and income <= 50000
), helper_hi
as(
	select 'High Salary' as category,count(*) as accounts_count from accounts
	where income > 50000
)
select * from helper_low
Union 
select * from helper_avg
union
select * from helper_hi;




