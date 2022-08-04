-- Generating the ranking of top customers by order value
select o.customer_id, c.company_name as customer_name, o.ship_country as customer_country,
	round(sum(t.product_values), 2) as brute_revenue,
	-- using a subselect to calculate the value of all orders
	round(100*sum(t.product_values)/(select sum(unit_price*quantity*(1-discount)) from order_details), 2) as 'revenue_share(%)',
    count(o.order_id) as tot_orders,
    round(sum(o.freight), 2) as freight_cost,
    round(100*sum(o.freight)/sum(t.product_values), 2) as "freight_weight(%)"
    
from orders as o

-- calculating the order value from the order_details table to later on be joined and agreggated by country
left join (select order_id, sum(unit_price*quantity*(1-discount)) as product_values
	from order_details
	group by order_id) as t   
ON o.order_id = t.order_id

left join customers as c
on o.customer_id = c.customer_id

group by o.customer_id, customer_name, customer_country
order by brute_revenue desc;