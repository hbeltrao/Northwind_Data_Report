select country, count(customer_id) AS tot_customers, ROUND(100*COUNT(*) / CAST( SUM(count(*)) over () as float), 2) AS 'customer_share(%)'
FROM customers
group by country
order by tot_customers desc;