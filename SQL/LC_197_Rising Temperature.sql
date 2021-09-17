/*
Write an SQL query to find all dates' id with higher temperature compared to its previous dates (yesterday).

Return the result table in any order.
Weather
+----+------------+-------------+
| id | recordDate | Temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
create table weather(id int, recordDate date, temperature int);

insert into weather
values
	(1,'2015-01-01',10),
	(2,'2015-01-02',25),
	(3,'2015-01-03',25),
	(4,'2015-01-04',30);
	
Result table:
+----+
| id |
+----+
| 2  |
| 4  |
+----+
*/



select * from weather;
-- WRong ans, may be missing date!
with diff_weather as
(
	select  *,
			(temperature - lag(temperature,1)
			-- KEY: lag is pointed to row before, seconde arg means how many rows ahead
			-- KEY: lead is pointed to row after, seconde arg means how many rows after
			 over(order by recordDate ASC
				 	)
			) as diff_temp
	from weather
) 
select id
from diff_weather 
where diff_temp > 0;

-- NOT using lag, find the temp of exact one day before
-- MYSQL not allow range in window function
with diff_weather as
(
	select  *,
			(min(temperature)
			 over(order by recordDate ASC
				  Range between '1 day' preceding and '1 day' preceding)
			) as prev_temp
	from weather
) 
select id
from diff_weather 
where temperature > prev_temp;

-- available in mysql, not in postgres sql
-- select id
-- from weather w1
-- where temperature > (select temperature 
-- 					 from weather w2
-- 					 where w2.recorddate = DATE_SUB(w1.recorddate, interval 1 day)
-- 					);


