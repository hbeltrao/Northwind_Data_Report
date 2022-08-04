select o.order_id, o.ship_country, c.company_name as customer_name, o.order_date,
	CASE WHEN (datediff(o.order_date, LAG(o.order_date, 1) over (partition by o.customer_id order by o.order_date asc))) IS NOT NULL
		THEN (datediff(o.order_date, LAG(o.order_date, 1) over (partition by o.customer_id order by o.order_date asc)))
        ELSE 0 END as days_between_orders,
    datediff(curdate(), max(o.order_date)over (partition by o.customer_id)) as days_since_last_order

from orders as o

left join customers as c
on o.customer_id = c.customer_id

order by customer_name, o.order_date ASC;