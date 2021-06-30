-- Offset Window Function
-- Offset from current row: LEAD, lAG
-- Offset from frame boundaries: FIRST_VALUE, LAST_VALUE,NTH_VALUE

/* Syntax
Row offset function (Expression [, offset, default])
{IGNORE | RESPECT} NULLs
OVER (...)

KEY: LEAD is pointed to AFTER, LAG is pointed to before
*/

-- Goal: show animal checkups, and how much weight they gained since last checkup
select species,name, checkup_time, weight,
		-- KEY: LAG is POINTED TO BEFORE
		weight - LAG(weight)
				 OVER(PARTITION BY species,name
					  ORDER BY checkup_time ASC) as weight_gained
from routine_checkups
order by species ASC, name ASC, checkup_time ASC;

/* Syntax
Frame Offset function (Expression [, offset, default])
[From {FIRST | LAST}]
{IGNORE | RESPECT} NULLs
OVER (... )

KEY: For all partition row, FIRST_VALUE, NTH_VALUE,LAST_VALUE will be the same
*/
-- GOAL: Show the weight gain for past 3 months

select species,name, checkup_time, weight,
		-- KEY: LAG is POINTED TO BEFORE
		(weight - FIRST_VALUE(weight)
				  OVER(PARTITION BY species,name
					   ORDER BY CAST(checkup_time AS DATE) ASC
					   RANGE BETWEEN '3 months' PRECEDING
					  					AND '1 day' PRECEDING)
		-- Each partition will have AT LEAST one row --> current row, which leads to numerous zeros
		)as weight_gained
from routine_checkups
order by species ASC, name ASC, checkup_time ASC;

-- In postgres cannot use abs is orderby, workaround is to use CTE
with weight_gain as
(
	select species,name, checkup_time, weight,
		-- KEY: LAG is POINTED TO BEFORE
		(weight - FIRST_VALUE(weight)
				  OVER(PARTITION BY species,name
					   ORDER BY CAST(checkup_time AS DATE) ASC
					   RANGE BETWEEN '3 months' PRECEDING
					  					AND '1 day' PRECEDING)
		-- Each partition will have AT LEAST one row --> current row, which leads to numerous zeros
		)as weight_gain_in_3_months
	from routine_checkups
)
select *
from weight_gain
order by abs(weight_gain_in_3_months) DESC NULLS LAST;



