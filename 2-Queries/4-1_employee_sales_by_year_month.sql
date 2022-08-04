select extract(Year_Month from o.order_date) as year_months, CONCAT(e.first_name," ", e.last_name) as employee_name,  ROUND(sum(t.order_value), 2) as revenue
from orders as o

left join (select order_id, sum(unit_price * quantity *(1- discount)) as order_value
		from order_details
        group by order_id) as t
on o.order_id = t.order_id

left join employees as e
on o.employee_id = e.employee_id


group by year_months, employee_name
order by year_months, employee_name;