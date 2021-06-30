-- Rank Window Function Syntax, Has following types of ranking function
-- RANK 
-- DENSE_RANK
-- ROW_NUMBER
-- NTILE

-- GOAL: Find the top 3 animals of each species with the largest number of checkups
-- including species with less than 3 animals

-- select * from reference.species;

select s.species, rc.name,
	   count(rc.checkup_time) as num_of_checkups
from reference.species as s
	 left join
	 routine_checkups as rc
	 on s.species = rc.species
group by s.species,rc.name
order by s.species ASC, num_of_checkups ASC;
-- Ferret, Raccoon are null

-- Subquery ver, with 2 CTEs
with animal_checkups as
(
	select s.species, rc.name,
	   count(rc.checkup_time) as num_of_checkups
	from reference.species as s
		 left join
		 routine_checkups as rc
		 on s.species = rc.species
	group by s.species,rc.name
), add_count_of_more_checked_animals as
(
	select *,
	   (
		   select count(*)
		   from animal_checkups as ac2
		   where ac1.species = ac2.species
		   		 AND
		    	 ac2.num_of_checkups > ac1.num_of_checkups
	   )as num_of_more_checked_animals
	from animal_checkups as ac1
)
select * from add_count_of_more_checked_animals
where num_of_more_checked_animals < 3
order by species ASC, num_of_checkups DESC;
-- KEY, requirement need to return no more than 3
-- We can see that when it comes to ranking, using subquery, CTEs are not convenient



-- Windows function ver(ROW_NUMBER)
with animal_checkups as
(
	select s.species, rc.name,
	   count(rc.checkup_time) as num_of_checkups
	from reference.species as s
		 left join
		 routine_checkups as rc
		 on s.species = rc.species
	group by s.species,rc.name
), row_number_by_num_of_checkups as
(
	select *,
	   ROW_NUMBER()
	   OVER( PARTITION BY species
			 ORDER BY num_of_checkups DESC, name ASC
	   )as row_number
	from animal_checkups
)
select *
from row_number_by_num_of_checkups
-- KEY, 不能直接用 row_number 因為這個attribute 還沒被computed (SELECT is  after WHERE),
-- 所以要把這個計算過程再丟到一個 CTE裡面, 最後再用where 來 filter
where row_number <= 3
order by species ASC, num_of_checkups DESC;
-- KEY, performance this is much better!

-- NTILE(N), 
select species, name, admission_date,
	   NTILE(30)
	   OVER( ORDER BY admission_date ASC)
	   AS ten_segments
	   -- 將total 分成 N個group, if uneven, 多的會加在前面
from animals
order by admission_date ASC;

select species, name, admission_date,
	   NTILE(30)
	   OVER(PARTITION BY species ORDER BY admission_date ASC)
	   AS ten_segments
	   -- if total < N, 則會 每個人分成一個segment
from animals
order by species ASC,admission_date ASC;

-- RANK() | DENSE_RANK()
-- OVER (Window.....)
-- RANK, DENSE_RANK 同樣的值都會是同個 rank, 但接下來會不會跳過, 
-- EX, 2個rank. For RANK, next will be rank = '4', For DENSE_RANK, next will be rank='3'
-- ROW_number won't recognize the same value, only generate unique row_number 

WITH all_ranks AS
(
	select species,name,
		   count(*) as number_of_checkups,
		   ROW_NUMBER(*) over W as row_number,
		   RANK(*) over W as rank,
		   DENSE_RANK(*) over W as dense_rank
	from routine_checkups
	group by species, name
	-- 	KEY, window 也可以擺在最後宣告
	WINDOW W as (PARTITION BY species ORDER BY COUNT(*) DESC)
)
select * 
from all_ranks
ORDER BY species ASC, number_of_checkups DESC;

WITH all_ranks AS
(
	select species,name,
		   count(*) as number_of_checkups,
		   ROW_NUMBER(*) over W as row_number,
		   RANK(*) over W as rank,
		   DENSE_RANK(*) over W as dense_rank
	from routine_checkups
	group by species, name
	-- 	KEY, window 也可以擺在最後宣告
	WINDOW W as (PARTITION BY species ORDER BY COUNT(*) DESC)
)
select * 
from all_ranks
-- WHERE row_number <= 3
WHERE rank <= 3
-- WHERE row_number <= 3
-- The condition using row_number/rank/dense_rank, need to depend on different situation
ORDER BY species ASC, number_of_checkups DESC;

