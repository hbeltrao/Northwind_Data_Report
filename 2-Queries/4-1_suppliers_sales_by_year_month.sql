select extract(Year_Month from o.order_date) as year_months, t.company_name as supplier_name,
sum(od.unit_price * od.quantity * (1 - od.discount)) as revenue

from order_details as od

left join orders as o
on od.order_id = o.order_id

left join (select p.product_id, s.company_name
		from products as p
        left join suppliers as s
        on p.supplier_id = s.supplier_id) as t
on od.product_id =  t.product_id

group by year_months, supplier_name
order by year_months;