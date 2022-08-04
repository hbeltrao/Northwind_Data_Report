select t.category_name,
	ROUND(sum(od.unit_price*od.quantity*(1-od.discount)), 2) as brute_revenue,
    ROUND(100*sum(od.unit_price*od.quantity*(1-od.discount))/(select sum(unit_price*quantity*(1-discount))
    from order_details), 2) as revenue_share

from order_details as od

left join (select p.product_id, p.product_name, c.category_name
			from products as p
            left join categories as c
            on p.category_id = c.category_id) as t
on od.product_id = t.product_id

group by t.category_name
order by revenue_share desc;