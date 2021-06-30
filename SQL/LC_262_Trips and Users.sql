-- Init Tables
-- create type status as enum('completed', 'cancelled_by_driver', 'cancelled_by_client');
-- create type banned as enum('Yes', 'No');
-- create type u_role as enum('client', 'driver','partner');
-- CREATE Table Trips(Id int, Client_Id int, Driver_Id int, City_Id int, Status status, Request_at date);
-- CREATE Table Users(Users_Id int, Banned banned, Role u_role);

-- select * from Trips;
-- select * from USERs;
-- insert into Trips
-- values('1', '1', '10', '1', 'cancelled_by_client', '2013-10-04');

-- insert into Users
-- values('1', 'No', 'client'),('10', 'No', 'driver')

-- insert into Trips
-- values
-- (1  , 1         , 10        , 1       , 'completed'           , '2013-10-01'),
-- (2  , 2         , 11        , 1       , 'cancelled_by_driver' , '2013-10-01'),
-- (3  , 3         , 12        , 6       , 'completed'           , '2013-10-01'),
-- (4  , 4         , 13        , 6       , 'cancelled_by_client' , '2013-10-01'),
-- (5  , 1         , 10        , 1       , 'completed'           , '2013-10-02'),
-- (6  , 2         , 11        , 6       , 'completed'           , '2013-10-02'),
-- (7  , 3         , 12        , 6       , 'completed'           , '2013-10-02'),
-- (8  , 2         , 12        , 12      , 'completed'           , '2013-10-03'),
-- (9  , 3         , 10        , 12      , 'completed'           , '2013-10-03'),
-- (10 , 4         , 13        , 12      , 'cancelled_by_driver' , '2013-10-03');
-- insert into Users
-- values
-- (1        , 'No'    , 'client'),
-- (2        , 'Yes'    , 'client'),
-- (3        , 'No'    , 'client'),
-- (4        , 'No'    , 'client'),
-- (10       , 'No'    , 'driver'),
-- (11       , 'No'    , 'driver'),
-- (12       , 'No'    , 'driver'),
-- (13       , 'No'    , 'driver');
/*
Write a SQL query to find the cancellation rate of requests 
with unbanned users (both client and driver must not be banned)
each day between "2013-10-01" and "2013-10-03".

The cancellation rate is computed 
by dividing the number of canceled (by client or driver) requests with unbanned users 
by the total number of requests with unbanned users on that day.

Return the result table in any order. Round Cancellation Rate to two decimal points.

The query result format is in the following example:

Thought Process:
1, Count all unbanned users on certain date
2, calculate the cancelled percentage 
3, group by day

*/

-- with unbanned_table as
-- (
-- 	select Users_id as unbanned_id
-- 	from users
-- 	where Banned = 'No'
-- )
-- select * from trips where Client_id in (select * from unbanned_table);

With non_banned_table as
(
	select Users_id as non_banned_id
	from users
	where Banned = 'No'
), cal_cancelled_table as
(
	select  *,
		  	Case When status != 'completed' then 1
				 else 0
			END 
			AS is_Cancelled
	from trips
	where Client_ID in (select non_banned_id from non_banned_table)
		and Driver_Id in (select non_banned_id from non_banned_table)
		and request_at between '2013-10-01' and '2013-10-03'
)
-- select * from unbanned_is_cancelled_table;
select request_at as Day,
		CAST(
			-- KEY, here need to *1.0 is to cast INT into Float, otherwise will only get 0
			1.0 * SUM(is_cancelled) / COUNT(is_cancelled)
			as Decimal(5,2)
		)as Cancellation_Rate
from cal_cancelled_table
group by request_at
order by day;















