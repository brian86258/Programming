-- Framing, further limit the window scope
-- Frame Boundaries Structure:
-- ORDER BY ...
-- ROWS | RANGE | GROUPS 
-- BETWEEN  (this means where the frame begin and end, N>=0)
-- -- UNBOUNDED PRECEDING | N PRECEDING | N FOLLOWING | CURRENT ROW
-- AND
-- -- UNBOUNDED PRECEDING | N PRECEDING | N FOLLOWING | CURRENT ROW

	
-- Queries from the previous chapter
SELECT 	a1.species,
		a1.name, 
		a1.primary_color, 
		a1.admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals AS a2
			WHERE 	a2.species = a1.species
		) AS number_of_species_animals
FROM 	animals AS a1
ORDER BY 	a1.species ASC,
			a1.admission_date ASC;

SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER (PARTITION BY species) 
			AS number_of_species_animals
FROM 	animals
ORDER BY 	species ASC,
			admission_date ASC;

-- Framing 
select species,
	   name,
	   max(name)
	   over(PARTITION by species 
		   ORDER BY Name 
				ROWS BETWEEN UNBOUNDED PRECEDING
				AND CURRENT ROW
	   		-- KEY, this order by, restric the window from all the preceding to the current row
			-- EXTRA note, because we select max, and order by ASC, so each next is larger than previous
			-- Can switch to DESC and see what happens 			
		   )
from animals;


-- COUNT the number of animals for same species on the previous date
-- subquery ver
SELECT 	a1.species,
		a1.name, 
		a1.primary_color, 
		a1.admission_date,
		(	SELECT 	COUNT (*) 
			FROM 	animals AS a2
			WHERE 	a2.species = a1.species
		 			AND
		 			a2.admission_date < a1.admission_date
		) AS number_of_species_animals
FROM 	animals AS a1
ORDER BY 	a1.species ASC,
			a1.admission_date ASC;

-- Window func ver
SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER (PARTITION BY species
			-- KEY, 這裡的order by是 這個window能看到的區域, 所以如果用DESC 跟 ASC會導致答案不一樣
			-- Alos, subquery is using '<=' or '>=' will include itself, so if want to exclude itself
			-- Should 1 PRECEDING as ending condition 			  
			ORDER BY admission_date ASC
			ROWS BETWEEN UNBOUNDED PRECEDING
						 AND
			  			 1 PRECEDING
-- 						 CURRENT ROW
			)AS number_of_species_animals
FROM 	animals
ORDER BY 	species ASC,
			admission_date ASC;
			
			
-- However the above solution stll have bug
-- Will have admission on the same date, but in previous solution, 
-- even they are on the same date, the latter position one will still add the previous 
-- since we only use "COUNT"
select species,
	   admission_date,
	   count(*)
from animals
group by species,admission_date
having count(*) > 1;

-- CTE solution
WITH filtered_animals as
(
	select *
	from animals
	where species = 'Dog'
		  AND
		  admission_date >'2017-08-01'
)
select fa1.species, fa1.name,
	   fa1.primary_color, fa1.admission_date,
	   (
		   select count(*)
		   from filtered_animals as fa2
		   where fa1.species = fa2.species
		   		 AND
		   		 fa2.admission_date < fa1.admission_date
	   )as up_to_previous_day_species_animals
from filtered_animals as fa1
order by fa1.species ASC, fa1.admission_date ASC;

-- Windows function
SELECT 	species, 
		name, 
		primary_color, 
		admission_date,
		COUNT (*) 
		OVER( PARTITION BY species
			   ORDER BY admission_date ASC
			   -- Notice, that we replace ROW -> RANGE, and N PRECEDING is not applicable for RANGE
			   RANGE BETWEEN UNBOUNDED PRECEDING
			  		 AND
			  		 '1 day' PRECEDING
		)as up_to_previous_day_species_animals
from animals
where species = 'Dog'
	  AND 
	  admission_date > '2017-08-01'
order by species ASC, admission_date ASC

-- ROW
-- RANGE  ==>  CUREENT ROW, Means the same range
-- GROUPS ==>  CUREENT ROW, Means the same group 

-- **KEY** Specifying OREDER BY without explicit frame boundaries 
-- **KEY** Will ASSUME default frame of "RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW"

-- NULL Handling:
-- Aggegate Function ignores NULLs
-- RANK respect NULLs




