select species,
	   count(*) as group,
	   -- Count all three row group, so three for all 
	   count(*)
	   OVER()
	   	As Window
from animals
group by species;


-- select species,
-- 	   count(*) as group,
-- 	   -- Use count name will be error! since cannot see name
--     -- THE window aggregate count don't have access to each row data
-- 	   count(name)
-- 	   OVER()
-- 	   	As Window
-- from animals
-- group by species;

select species,
	   count(*) as group,
	   sum(count(name))
	   -- KEY:這裡的SUM 是 window aggregate
	   -- KEY:這裡的COUNT 是 group by aggregate, 因為是group by 所以可以access到每個row 去count name  
	   -- 所以這裡的 window 是 across all three groups, how many names in each group and sum them up
	   OVER()
	   	As Window
from animals
group by species;


select * from adoptions;

-- GOAL: Show year, month, monthly revenue and percent of current year

-- Count month total revenue
select DATE_PART('year', adoption_date) as year,
	   DATE_PART('month', adoption_date) as month,
	   sum(adoption_fee) as month_total
from adoptions
group by DATE_PART('year', adoption_date), DATE_PART('month', adoption_date)
order by year ASC, month ASC;

-- count yearly percentage (wrong)
-- select DATE_PART('year', adoption_date) as year,
-- 	   DATE_PART('month', adoption_date) as month,
-- 	   sum(adoption_fee) as month_total,
-- 	   CAST( 100 * SUM(adoption_fee)
-- 				-- The same error, in window function cannot access each row
-- 				-- So adoption_fee cannot be seen in window function
-- 				-- Has to use the "group by" aggregation first 				
-- 				/ SUM(adoption_fee) OVER (PARTITION BY DATE_PART('year', adoption_date))
-- 			AS decimal(5,2)		   
-- 	   )as annual_percent
-- from adoptions
-- group by DATE_PART('year', adoption_date), DATE_PART('month', adoption_date)
-- order by year ASC, month ASC;

select DATE_PART('year', adoption_date) as year,
	   DATE_PART('month', adoption_date) as month,
	   sum(adoption_fee) as month_total,
	   CAST( 100 * SUM(adoption_fee)	
				-- KEY: First SUM() is window aggregation
				-- Second SUM() is the group by sum
				-- It firstly compute the month_revenue by group_by sum ,
				-- then the window sum adds up all the month_revenue by year
				/ SUM(SUM(adoption_fee)) OVER (PARTITION BY DATE_PART('year', adoption_date))
			AS decimal(5,2)		   
	   )as annual_percent
from adoptions
group by DATE_PART('year', adoption_date), DATE_PART('month', adoption_date)
order by year ASC, month ASC;

-- USE Window function to comput annual_sum
select DATE_PART('year', adoption_date) as year,
	   DATE_PART('month', adoption_date) as month,
	   sum(adoption_fee) as month_total,
	   SUM(SUM(adoption_fee)) OVER (PARTITION BY DATE_PART('year', adoption_date))
	   as annual_sum
from adoptions
group by DATE_PART('year', adoption_date), DATE_PART('month', adoption_date)
order by year ASC, month ASC;

-- USING CTE for simpler explanation (把CTE 想成是Local的一個table)
WITH monthly_grouped_adoptions as
(
	select DATE_PART('year', adoption_date) as year,
	   DATE_PART('month', adoption_date) as month,
	   sum(adoption_fee) as month_total
from adoptions
group by DATE_PART('year', adoption_date), DATE_PART('month', adoption_date)
order by year ASC, month ASC
)
select *, 
	   SUM(month_total)
	   over(partition by year) as annual_sum,
	   CAST( 100 * month_total 
				 / SUM(month_total) over(partition by year)
			as DECIMAL(5,2)
	   )as annual_percentage
from monthly_grouped_adoptions;
