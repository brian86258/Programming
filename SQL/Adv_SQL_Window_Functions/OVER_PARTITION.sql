-- OVER PARTITION
-- Add a col show the total number of species instead of total animals


-- subquery ver, note this is really inefficient, since it has to do 100 count(*)
select a1.species,
	   a1.name,
	   a1.primary_color,
	   a1.admission_date,
	   (
		   select count(*)
		   from animals as a2
		   where a2.species = a1.species
	   )as num_of_species_animals
from animals as a1
order by a1.species ASC,
		 a1.admission_date ASC;
		 
-- more efficient subquery ver, pre join the table
-- it will count each row after group (reducce 100 -> 3)
select a1.species,
	   a1.name,
	   a1.primary_color,
	   a1.admission_date,
	   species_counts.num_of_species_animals
from animals as a1
	 inner join(
		 select species,
		 		count(*) as num_of_species_animals
		 from animals
		 group by species
	 )as species_counts
	 on a1.species = species_counts.species
order by a1.species ASC,
		 a1.admission_date ASC;
		 
		 
-- OVER(PARTITION by)
-- KEY: Note that, using over we don't have to use another table
-- which can hugely simplify the query, 
-- and we don't have to consider all the join and other table
-- AND faster

select species,
	   name,
	   primary_color,
	   admission_date,
	   count(*)
	   over(PARTITION by species) as 
	   num_of_species_animals
from animals
order by species ASC,
		 admission_date ASC;