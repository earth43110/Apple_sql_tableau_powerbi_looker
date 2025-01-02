/* 
List of SQL queries to showcase SQL skills of increasing complexity.
*/

--Q1. Find each country and number of stores
select 
	stores.country,
	count(*) as number_of_stores
from stores
group by country
order by country;

--Q2. What is the total number of units sold by each store?
select 
	stores.store_id,
	stores.store_name,
	sum(sales.quantity) total_no_of_units_sold
from stores
join sales
	on stores.store_id = sales.store_id
group by 1,2
order by 3 desc;

--Q3. How many sales occurred in December 2023?
--3 ways to do this
--Query 1
select
	count(sales.sale_id) as total_sales
from sales
where extract('year' from sales.sale_date) = '2023' and extract('month' from sales.sale_date) = '12';

--Query 2
select
	count(sales.sale_id) as total_sales
from sales
where to_char(sales.sale_date, 'MM-YYYY') = '12-2023';

--Query 3
select
	count(sales.sale_id) as total_sales
from sales
where sales.sale_date between '2023-12-01' and '2023-12-31';

--Q4. How many stores have never had a warranty claim filed against any of their products?
select 
	count(*) as no_of_stores_with_no_warranty_claims
from stores
where store_id not in (
	select distinct store_id
	from sales
	right join warranty
		on sales.sale_id = warranty.sale_id
);

--Q5. What percentage of warranty claims are marked as "Warranty Void"?
--warranty void/total * 100
select
	round(
		count(claim_id) / (select count(*) from warranty)::numeric * 100
		,2) 
	as warranty_void_claims
from warranty
where repair_status = 'Warranty Void';

--Q6. Which store had the highest total units sold in the last year?
select 
	sales.store_id,
	stores.store_name,
	sum(sales.quantity) total_units_sold
from stores
join sales
	on stores.store_id = sales.store_id
where to_char(sales.sale_date, 'YYYY') = '2024'
group by 1,2
order by 3 desc
--limit 1;

--Q7. Count the number of unique products sold in the last year.
select 
	count(distinct sales.product_id) as no_of_unique_products_sold_last_year
from sales
where to_char(sales.sale_date, 'YYYY') = '2023';

--Q8. What is the average price of products in each category?
select
	category.category_id,
	category.category_name,
	round(avg(products.price)::numeric,2) as average_product_price
from category
join products
	on category.category_id = products.category_id
group by 1,2;

--Q9. How many warranty claims were filed in 2020?
select 
	count(*) as no_of_warranty_claims_2020
from warranty
where extract(year from claim_date) = 2020;

--Q10. Identify each store and best selling day based on highest qty sold
select * 
from 
(
select 
	sales.store_id,
	to_char(sales.sale_date, 'day') as day_name,
	sum(sales.quantity) as highest_quantity_sold,
	rank() over(partition by store_id order by sum(quantity) desc) as rank
from sales
group by 1,2
) 
where rank = 1;

--Q11. Identify least selling product of each country for each year based on total unit sold
with product_rank as 
(
select 
	stores.country,
	products.product_name,
	sum(sales.quantity) as total_qty_sold,
	rank() over(partition by stores.country order by sum(sales.quantity)) as rank
from products
join sales
	on products.product_id = sales.product_id
join stores
	on sales.store_id = stores.store_id
group by 1,2
)
select * 
from product_rank
where rank = 1;

--Q12. How many warranty claims were filed within 180 days of a product sale?
select 
	count(warranty.claim_id)
from warranty
left join sales
	on warranty.sale_id = sales.sale_id
where warranty.claim_date - sales.sale_date <= 180;

--Q13.  Determine how many warranty claims were filed for products launched in the last two years.
select 
	products.product_name,
	count(warranty.claim_id) as no_warranty
from warranty
join sales on warranty.sale_id = sales.sale_id
join products on sales.product_id = products.product_id
where products.launch_date >= CURRENT_DATE - INTERVAL '2 years'
group by 1;

-- Q.14 List the months in the last three years where sales exceeded 5,000 units in the USA.
select 
	to_char(sales.sale_date, 'MM-YYYY') as month_name,
	count(sales.sale_id) as sales_qty
from sales
join stores on sales.store_id = stores.store_id
where sales.sale_date >= current_date - interval '3 years'
	and stores.country = 'USA'
group by 1
having count(sales.sale_id) > 5000;

-- Q.15 Identify the product category with the most warranty claims filed in the last two years.
select 
	category.category_name,
	count(warranty.claim_id) as no_warranties
from category
join products on category.category_id = products.category_id
join sales on products.product_id = sales.product_id
join warranty on sales.sale_id = warranty.sale_id
where warranty.claim_date >= current_date - interval '2 years'
group by 1
order by 2 desc
limit 1;

-- Q.16 Determine the percentage chance of receiving warranty claims after each purchase for each country.
select 
	stores.country,
	products.product_name,
	sales.sale_id,
	round((count(warranty.claim_id)::numeric / count(sales.sale_id) over(partition by product_name)) *100, 2)as percentage_chance_of_warranty_claim
from sales
join warranty
	on sales.sale_id = warranty.sale_id
join products 
	on sales.product_id = products.product_id
join stores 
	on sales.store_id = stores.store_id
group by 1,2,3
order by percentage_chance_of_warranty_claim desc;

--Q17. Categorize the number of units sold by store as sales being 'high', 'medium', and 'low'.
--determine the ranges of 'high', 'medium', 'low'
select 
	min(total_units_sold) as min,
	round((min(total_units_sold) + ((avg(total_units_sold)-min(total_units_sold))/2)),0) as min_range,
	round(avg(total_units_sold), 0) as average,
	round((avg(total_units_sold) + ((max(total_units_sold)-avg(total_units_sold))/2)),0) as max_range,
	max(total_units_sold) as max
from
(
select 
	stores.store_name,
	count(sales.sale_id) as total_units_sold
from products
join sales on products.product_id = sales.product_id
join stores on sales.store_id = stores.store_id
group by 1
)

--using the calculated ranges in above query, display the stores, units_sold, and category
select 
	stores.store_name,
	count(sales.sale_id) as total_units_sold,
	case 
		when count(sales.sale_id) <= 7753 then 'low'
		when count(sales.sale_id) between 7753 and 26168 then 'medium'
		when count(sales.sale_id) >= 26168 then 'high'
	end as category
from products
join sales on products.product_id = sales.product_id
join stores on sales.store_id = stores.store_id
group by 1
order by 2;



































	









