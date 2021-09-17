/*
1113. Reported Posts

Write an SQL query that reports the number of posts reported yesterday for each report reason. Assume today is 2019-07-05.

The query result format is in the following example:
*/
with helper
as (
select  post_id, action, extra
from actions
where action_date ='2019-07-04' and action = 'report' AND extra IS NOT NULL
group by post_id,action,extra
)select distinct extra as report_reason, count(*) over(partition by extra) as report_count
from helper
order by report_count;

-- today is 2019-07-05


