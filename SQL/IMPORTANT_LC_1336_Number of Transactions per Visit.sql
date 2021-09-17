/*1336. Number of Transactions per Visit
Write an SQL query to find how many users visited the bank and didn't do any transactions, how many visited the bank and did one transaction and so on.

The result table will contain two columns:

transactions_count: which is the number of transactions done in one visit.
visits_count: which is the corresponding number of users who did transactions_count in one visit to the bank.

transactions_count should take all values from 0 to max(transactions_count) done by one or more users.

Order the result table by transactions_count.


*/
with Recursive trans_counts  
as(
	select v.user_id, v.visit_date, count(transaction_date) as trans_count
	from visits v
	left join transactions t on (v.user_id = t .user_id and v.visit_date = t.transaction_date )
	group by v.user_id, v.visit_date
	
), trans_counts_value
as(
	select max(trans_count) as trans_id from trans_counts
	UNION ALL
	select trans_id-1 from trans_counts_value
	where trans_id >0
)select TCV.trans_id as transactions_count, count(TC.trans_count) as visits_count
from trans_counts_value TCV
left join trans_counts TC on TCV.trans_id = TC.trans_count
group by TCV.trans_id
order by TCV.trans_id;



/*KEY, 不能count(*) 如果是null count部會算進來, 所以要count TC.trans_count*/















/* Solution:https://leetcode.com/problems/number-of-transactions-per-visit/discuss/1359102/MySQL%3A-CTEs-with-detailed-explanation
with Recursive trans_counts  
AS (
SELECT
  V.user_id,
  V.visit_date,
  COUNT(T.transaction_date) AS trans_count
FROM
  Visits V
  LEFT JOIN Transactions T
    ON V.visit_date = T.transaction_date 
      AND V.user_id = T.user_id
GROUP BY
  V.user_id, V.visit_date
), trans_count_vals 
as(
	select max(TC.trans_count) as trans_id from trans_counts TC --anchor member
	UNION ALL
	SELECT trans_id - 1 FROM trans_count_vals   -- recursive member
	WHERE trans_id > 0 -- terminate condition
)select 
  TCV.trans_id AS transactions_count,
  COUNT(TC.trans_count) AS visits_count
from trans_count_vals TCV
left join trans_counts TC on TC.trans_count = TCV.trans_id
group by TC.trans_count, TCV.trans_id
order by transactions_count;


Recursive CTE USAGE:
with recursive cte
as (
	select min(id) as min_d_id, max(id) as max_d_id from departments --anchor member
	UNION ALL -- must have UNION ALL
	select min_d_id+1, max_d_id from cte -- recursive member
	where min_d_id < max_d_id -- terminator
)
select * from cte;

with recursive cte
as (
	select max(id) as d_id from departments --anchor member
	UNION ALL -- must have UNION ALL
	select d_id -1 from cte -- recursive member
	where d_id >= 0 -- terminator
)
select * from cte;

*/ 