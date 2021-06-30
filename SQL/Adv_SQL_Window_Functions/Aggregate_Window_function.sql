-- The Difference of "GROUP AGGREGATION" & "WINDOW AGGREGATION"

select count(*) as COUNT, species
from animals
group by species;

-- select count(*) as COUNT, species,name
-- from animals
-- group by species;
-- NOTE here if select name, will become error, because, after the group by
-- There may be multiple name for the same group, such ambiguity is not allowed by DB

select count(*) as COUNT, species, max(name)
from animals
group by species;
-- However, using aggregation can show the name 

-- **Important KEY** 
-- OVER: used in SELECT and ORDER BY
-- See ALL GROUP but cannot see each ROW
-- GROUP BY: used in HAVING, SELECT and ORDER BY
-- Can see all row in the same group but cannot see all groups

select * 
from routine_checkups
order by species ASC, checkup_time ASC;

-- GOAL: Return an animal's species,name,checkup time, heart rate and a Boolean col that is True
-- For animals which all of their heart rate measurements were either equal to or larger than 
-- the average heart rate for their species 

-- Calculate the avergae heart_rate
select species,
	   name,
	   checkup_time,
	   heart_rate,
	   cast(
		   avg(heart_rate)
		   over(partition by species)
		   as DECIMAL(5,2)
	   )as species_average_heart_rate
from routine_checkups;


-- IMPORTANT KEY, Window function cannot be nested
-- select species,
-- 	   name,
-- 	   checkup_time,
-- 	   heart_rate,
-- 	   EVERY(
-- 		   heart_rate >= avg(heart_rate)
-- 		   over(Partition by species)
-- 	   )
-- 	   OVER(Partition by species,name) as consistnetly_at_or_above_average
-- from routine_checkups
-- ORDER BY species ASC, checkup_time ASC;

-- CTE solution:
-- First use CTE creat a table contain the avg heart rate
-- Then use window function to check the same table, wheter this animal(over parition by species,name)
-- all the heart heart rate is above average, 
-- BUT STILL ERROR, since window function cannot be used in where

WITH species_average_heart_rates
AS
(
SELECT 	species, 
		name, 
		checkup_time, 
		heart_rate, 
		AVG (heart_rate) 
		OVER (PARTITION BY species) AS species_average_heart_rate
FROM	routine_checkups
)
SELECT	species, 
		name, 
		checkup_time, 
		heart_rate
FROM 	species_average_heart_rates
WHERE 	EVERY (heart_rate >= species_average_heart_rate) 
		OVER (PARTITION BY species, name)
ORDER BY 	species ASC,
			checkup_time ASC;

