/*
Strategy
1, calculate the average of species, and the difference to that average
2, calculate the proportion
3, groupy by exception
4, use ntile to find top 25 %
*/

With average_table as
(
	Select  species,
			name,
		    temperature,
		    checkup_time,
			CAST(
				AVG(temperature)
				OVER(PARTITION BY species)
				as decimal(5,2)
			)as species_average_temperature,
			CAST(
				temperature - AVG(temperature) OVER(PARTITION BY species)
				as decimal(5,2)
			)as temperature_diff
	from routine_checkups
)
-- select * from average_table order by species ASC, temperature_diff DESC;
, is_exception_table as
(
	select  *,
			CASE WHEN abs(temperature_diff / species_average_temperature) >= 0.005 
					THEN 1
			ELSE 0
		   	END AS is_exception
	from average_table
)
-- select * from is_exception_table order by species ASC, temperature_diff DESC;
, grouped_by_table as
(
	select  species,name,
			SUM(is_exception) as number_of_exceptions,
			MAX(
				CASE WHEN is_exception = 1 THEN checkup_time
				ELSE NULL
				END
			) as latest_exception
	from is_exception_table
	group by species,name
	order by species ASC, number_of_exceptions
)
-- select * from grouped_by_table order by species ASC;
, animal_with_ntile_table as 
(
	select  *,
		    NTILE(4)
			OVER(PARTITION BY species 
				 ORDER BY number_of_exceptions ASC,latest_exception DESC
				 --KEY, 這裡重要的是number_of_exceptions 一定要 ASC, 才會取到前25%, latest_exception 只是取決於當今天 number_of_exception 同樣是前25%時, 是日期早的優先還是日期晚的優先
				 )as ntile
	from grouped_by_table
)
-- select * from animal_with_ntile_table order by species ASC;
SELECT  species,
	   	name,
		number_of_exceptions,
		latest_exception
from animal_with_ntile_table
where ntile =1 
ORDER by species ASC, number_of_exceptions DESC, latest_exception DESC;
