/*
Write an SQL query to find the most recent order(s) of each product.
Return the result table sorted by product_name in ascending order and in case of a tie by the product_id in ascending order. 
If there still a tie, order them by the order_id in ascending order.
The query result format is in the following example:
*/


-- select * from customers;
-- select * from orders;
with helper_table
as(
	select p.product_id, product_name, order_date,order_id,
			max(order_date)
			over(partition by p.product_id) as latetest_date
	from products p
	join orders o on p.product_id = o.product_id
)select product_name, product_id, order_id, order_date
from helper_table
where order_date = latetest_date
order by product_name, product_id, order_id ASC;


