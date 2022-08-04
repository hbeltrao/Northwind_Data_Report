select extract(Year_Month from o.order_date) as year_months, c.company_name,
	ROUND(AVG(t.order_value), 2) as average_ticket,
    count(o.order_id) as orders
    
from orders as o

left join (select order_id, sum(unit_price * quantity *(1- discount)) as order_value
		from order_details
        group by order_id) as t
on o.order_id = t.order_id

left join customers as c
on o.customer_id = c.customer_id

group by year_months, c.company_name
order by year_months;