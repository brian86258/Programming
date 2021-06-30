-- DISTRIBUTION function
-- PERCENT_RANK | CUME_DIST. CUME 

with average_weights as
(
	select species,name,
	   CAST(
		   AVG(weight)
		   as DECIMAL(5,2)
	   )as average_weight
	from routine_checkups
	group by species,name
)
select *,
	   PERCENT_RANK() OVER W as percent_rank,
	   CUME_DIST() OVER W as cumulative_distribution
from average_weights
WINDOW W as (PARTITION BY species order by average_weight)
order by species desc, average_weight DESC;



