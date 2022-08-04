-- Query to calculate the value of all orders and aggregate per country, disconsidering freight cost, and calculating the percentual representation of each country
-- on the total value of orders in the sample.
select o.ship_country, round(sum(t.product_values), 2) as brute_revenue,
	-- using a subselect to calculate the value of all orders
	round(100*sum(t.product_values)/(select sum(unit_price*quantity*(1-discount)) from order_details), 2) as 'revenue_share(%)'
    
from orders as o

-- calculating the order value from the order_details table to later on be joined and agreggated by country
left join (select order_id, sum(unit_price*quantity*(1-discount)) as product_values
	from order_details
	group by order_id) as t   
ON o.order_id = t.order_id

group by o.ship_country
order by brute_revenue desc;