select t.product_name, t.origin_country,t.supplier,
	sum(od.unit_price * od.quantity * (1-od.discount)) as revenue, 
    count(od.order_id) as total_orders,
    round(100*sum(od.unit_price * od.quantity * (1-od.discount))/(select sum(unit_price*quantity*(1-discount)) from order_details), 2) as 'revenue_share(%)'

from order_details as od

left join (select p.product_id, p.product_name, s.country as origin_country, s.company_name as supplier
			from products as p
            left join suppliers as s
            on p.supplier_id = s.supplier_id) as t
on od.product_id = t.product_id

group by t.product_name, t.origin_country, t.supplier
order by revenue desc;