select extract(Year_Month from o.order_date) as year_months, ROUND(AVG(t.order_value), 2) as average_ticket,
		COUNT(o.order_id) as tot_orders
from orders as o

left join (select order_id, sum(unit_price * quantity *(1- discount)) as order_value
		from order_details
        group by order_id) as t
on o.order_id = t.order_id

group by year_months
order by year_months;
        