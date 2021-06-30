-- Structure:
-- FUNCTION (COUNT,AVG ....)
-- FILTER (WHERE condition)
-- OVER (PARTITION/RANK ...)



-- NOTE that, if not using subquery
-- It's impossible to access data from another row
-- That's why window function is useful, especially it can speed up the query

-- subquery ver
select species,
	   name,
	   primary_color,
	   admission_date,
	   (
		   select count(*)
		   from animals
	   )as number_of_animals
from animals
order by admission_date ASC;

-- Empty over, means from the same table and no further filter
select species,
	   name,
	   primary_color,
	   admission_date,
	   count(*)
	   OVER () as number_of_animals
from animals
order by admission_date ASC;


-- KEY different filter will act differently

-- 下面的where 沒有去限制, 所以會取所有 100 個 row
-- 這裡的filter, 是針對新的window function, 所以number_of_animals 只有取道75 row
SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*)
		FILTER (WHERE admission_date >= '2017-01-01')
		OVER () AS number_of_animals
FROM 	animals
ORDER BY admission_date ASC;

-- 這裡的是從where 就開始去做限制, 所以 over裡面取到的 
-- 是已經 filter過一次的table, 所以total 只有 取75 rows
SELECT 	species,
		name, 
		primary_color, 
		admission_date,
		COUNT (*)
		OVER () AS number_of_animals
FROM 	animals	
WHERE 	admission_date >= '2017-01-01'
 ORDER BY admission_date ASC;






