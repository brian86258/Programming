/*
Write a SQL query to delete all duplicate email entries in a table named Person, keeping only unique emails based on its smallest Id.

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.
*/


-- create table person(Id int,Email varchar);
-- insert into person 
-- values	
-- 		(1, 'john@example.com'),
-- 		(2, 'bob@example.com'),		
-- 		(3, 'john@example.com');		

-- delete from person;
-- select * from person;

with duplicate_table as
(
	select  *,
			ROW_NUMBER()
			OVER(PARTITION BY email
				ORDER BY id)
			-- 	KEY: 要加上 order by id, 這樣 是id 比較大的數字, duplicate_num 才會大於一, 在之後delete才會刪到比較後面的ID
			as duplicate_num
	from person
)
-- KEY: CANNOT DELETE FROM CTE, since it will disappear after this query.
-- So use CTE as a index to delete in REAL table
delete from person 
where id in (select id 
			 from duplicate_table 
			 where duplicate_num >1);