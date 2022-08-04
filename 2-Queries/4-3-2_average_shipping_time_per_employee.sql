select EXTRACT(Year_Month from o.order_date) as year_months, CONCAT(e.first_name," ", e.last_name) as employee_name,
		-- Using timestampdiff() to have more precision and correctly calculate when the difference is less than an day
		ROUND(AVG(timestampdiff(HOUR, o.order_date, o.shipped_date)/24), 2) AS average_shipping_time,
        count(o.order_id) as orders
        
from orders as o

left join employees as e
on o.employee_id = e.employee_id

group by year_months, employee_name
order by year_months;