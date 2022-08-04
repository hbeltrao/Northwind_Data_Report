select EXTRACT(Year_Month from order_date) as year_months, 
		-- Using timestampdiff() to have more precision and correctly calculate when the difference is less than an day
		ROUND(AVG(timestampdiff(HOUR, order_date, shipped_date)/24), 2) AS average_shipping_time,
        count(order_id) as orders
from orders
group by year_months
order by year_months;