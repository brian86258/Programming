
With yearly_vaccinaiton as
(
	select DATE_PART('year',vaccination_time) as year,
		   count(*) as number_of_vaccinations
	from vaccinations
	group by DATE_PART('year',vaccination_time)
	order by DATE_PART('year',vaccination_time)
)
select *,
	   CAST(
		   avg(number_of_vaccinations)
		   over(
				ORDER BY year
				ROWS BETWEEN 2 PRECEDING
				AND 1 PRECEDING
			   )
		   as DECIMAL(5,2)
	  )as previous_2_years_average,
	  CAST( 100 * number_of_vaccinations
		   		/  avg(number_of_vaccinations)
		   		over(
				ORDER BY year
				ROWS BETWEEN 2 PRECEDING
				AND 1 PRECEDING
			   	)
		   as DECIMAL(5,2)
	  )
from yearly_vaccinaiton
order by year;