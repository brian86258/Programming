-- BREAK the task into 4 part
-- 1, Find the average temperature of the species, and calculate the difference
-- 2, Calculate the difference with the average
-- 3, Group by the species, name
-- 4, Use Ntile to get the top 25% of members
WITH checkups_with_temperature_differences
AS -- First CTE
(
	select species,
		   name,
		   temperature,
		   checkup_time,
		   CAST(
			   AVG(temperature)
			   OVER(PARTITION BY species)
			   as decimal(5,2)
		   )as species_average_temperature,
		   CAST(
			   temperature - AVG(temperature)
			   OVER(PARTITION BY species)
			   as decimal(5,2)
		   )AS difference_from_average
	from routine_checkups
)
-- SELECT * FROM checkups_with_temperature_differences ORDER BY species, difference_from_average;
, temperature_differences_with_exception_indicator
AS -- Second CTE
(
	select *,
		   CASE
		   WHEN abs(difference_from_average / species_average_temperature) >= 0.005 THEN 1
		   ELSE 0
		   END AS is_tmeperature_exception
	from checkups_with_temperature_differences
)
-- SELECT * FROM temperature_differences_with_exception_indicator ORDER BY species, difference_from_average;
, grouped_animals_with_exceptions
AS -- Third CTE
(
	select  species,
			name,
			sum(is_tmeperature_exception) as number_of_exceptions,
			-- LAST checkup time
			MAX( CASE
				 WHEN is_tmeperature_exception =1
					then checkup_time
				 ELSE NULL
				 END
				)as latest_exception
	from temperature_differences_with_exception_indicator
	group by species,name
)
-- SELECT * FROM grouped_animals_with_exceptions ORDER BY species, number_of_exceptions;
, animal_exceptions_with_ntile
AS
(
	select *,
		   -- Since we want top 25%, which is 1/4
		   NTILE (4)
		   OVER(
			   PARTITION BY species
			   ORDER BY number_of_exceptions ASC, latest_exception DESC
		   )as ntile
	from grouped_animals_with_exceptions
)
-- SELECT * FROM animal_exceptions_with_ntile ORDER BY species, number_of_exceptions, latest_exception DESC;
SELECT  species,
	   	name,
		number_of_exceptions,
		latest_exception
from animal_exceptions_with_ntile
where ntile =1 
ORDER by species ASC, number_of_exceptions DESC, latest_exception DESC;
	  	 
		
