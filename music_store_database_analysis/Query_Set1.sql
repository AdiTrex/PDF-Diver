/* senior most employee based on job title */
select * from employee
where levels = 'L7'

/* country with most invoice  */

select count(invoice_id) as t ,billing_country
from invoice
group by billing_country
order by t desc
limit 1

/* top 3 values of total invoice */

select total from invoice
order by total desc
limit 3

/* which city has the best customers? We would like to throw a promtional
music festival in the city we made the most money. write a query that
returns one city that has the highest sum of invoice totals. Return both
the city name & sum of all invoice totals  */

select sum(total) as total_invoice,billing_city 
from invoice
group by billing_city
order by total_invoice desc
limit 1

/* name of customer that spent highest money */

select customer.customer_id ,customer.first_name,customer.last_name, sum(invoice.total) as cust_total
from customer
join invoice ON customer.customer_id = invoice.customer_id
group by customer.customer_id
order by cust_total desc
limit 1



 



