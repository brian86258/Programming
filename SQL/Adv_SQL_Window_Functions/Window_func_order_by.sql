select species,
	   name,
	   weight,
	   CAST(
		  AVG(weight)
		  OVER(PARTITION by species,name
			   ORDER by weight ASC
			   ROWS BETWEEN UNBOUNDED PRECEDING
			   AND CURRENT ROW
			  )
		  as decimal(5,2) 
	   )as avg_weight
from routine_checkups
order by species DESC,name ASC, weight ASC;
	
-- IN window if no order by, then the window will be the whole subgroup, 
-- However, if Use ORDER BY, need to consider the range, PRECEDING .... etc, NEED TO CAREFUL
select species,
	   name,
	   weight,
	   CAST(
		  AVG(weight)
		  OVER(PARTITION by species,name
			  )
		  as decimal(5,2) 
	   )as avg_weight
from routine_checkups
order by species DESC,name ASC, weight ASC;