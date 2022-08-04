select sp.country, count(distinct sp.supplier_id) as suppliers,
	count(sp.product_id) as tot_products, 
    count(distinct sp.product_id) as unique_products,
    round(sum((od.unit_price * od.quantity)*(1 - od.discount)), 2) as revenue,
    round(100*sum((od.unit_price * od.quantity)*(1 - od.discount))/(select sum((unit_price * quantity)*(1 - discount)) from order_details), 2) as "revenue_%"

from order_details as od

left join (select p.product_id, s.supplier_id, s.company_name, s.country
			from products as p
            left join suppliers as s
            on p.supplier_id = s.supplier_id) as sp
on od.product_id = sp.product_id

left join orders as o
on od.order_id = o.order_id

group by sp.country
order by revenue desc;
            