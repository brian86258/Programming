-- create table Logs(Id int, Num int);
-- insert into Logs
-- values 
-- 		(1,3),
-- 		(2,3),
-- 		(3,3),
-- 		(4,3);
		
-- insert into Logs
-- values 
-- 		(1,1),
-- 		(2,1),
-- 		(3,1),
-- 		(4,2),
-- 		(5,1),
-- 		(6,2),
-- 		(7,2);
		
		
-- select * from Logs;
-- delete from logs;


-- Write an SQL query to find all numbers that appear at least three times consecutively.
-- Return the result table in any order.
-- The query result format is in the following example:

-- CTE version
-- with two_prev_table as 
-- (
--     select Id+2 as id, 
--            Num
--     from Logs    
-- ), one_prev_table as
-- (
--     select  Id+1 as id,
--             Num
--     from Logs
-- )
-- select Distinct L.num as ConsecutiveNums 
-- from Logs as L 
-- left join two_prev_table as two
--     on L.id = two.id
-- left join one_prev_table as one_T
--     on L.id = one_T.id
-- where L.num = two.num  and L.num = one_T.num


-- Window Func ver
with pre_table as 
(
	select id, num,
			max(num)
			OVER(order by id 
				 ROWS BETWEEN 2 preceding
					AND 2 preceding)
			as prev2_num,
			max(num)
			OVER(order by id
				 ROWS BETWEEN 1 preceding
					AND 1 preceding)
			as prev1_num
	from Logs
)select distinct num as ConsecutiveNums 
from pre_table
where num = prev2_num and num = prev1_num;