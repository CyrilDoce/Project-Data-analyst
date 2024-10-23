--This sql file was used when cleaning the following files in SQL server: "Data transformation - Power Query.xlsx" and "Data cleaning - Excel and SQL server.xlsx" .
--Both are named "PQ" and "clean" respectively as tables within this file.
--This file was used to clean both tables and join them finally to create the final product table in which data analysis and data visualisation would proceed.

-- Select all the data from the "PQ" table

select *
from pq

-- Identify any null values within either user_name, review_id or user_id columns within the "PQ" table

select *
from pq
where review_id is null or user_name is null or user_id is null

-- Delete these rows
delete 
from pq
where review_id is null or user_name is null or user_id is null

select *
from pq

-- Identify values that are duplicated within the "clean" table
with checkDuplicated as(
select  *,
row_number() over( partition by product_id, product_name, category, discounted_price, actual_price, 
check_discounted_price, discount_percentage, rating, rating_count order by product_id) as rank
from clean)

-- Delete duplicated rows

delete
from checkDuplicated
where rank > 1

-- Join the "Clean" table and "PQ" table on the product_id
select pq.product_id, clean.product_name, clean.category,clean.actual_price, clean.discount_percentage,
clean.check_discounted_price,clean.rating,clean.rating_count, pq.user_id, pq.user_name, pq.review_id
from clean 
join pq on 
	pq.product_id = clean.product_id

-- Create the final table

create table FinalProductTable (
	product_id nvarchar(100) ,
	product_name varchar(500),
	category varchar(100),
	actual_price decimal(10,2),
	discount_percentage decimal(10,2),
	check_discounted_price decimal(10,2),
	rating float,
	rating_count int,
	user_id varchar(100),
	user_name varchar(100),
	review_id varchar(100)
)

drop table FinalProductTable

insert into FinalProductTable
select pq.product_id, clean.product_name, clean.category, clean.actual_price, clean.discount_percentage,
clean.check_discounted_price,clean.rating,clean.rating_count, pq.user_id, pq.user_name, pq.review_id
from clean 
join pq on 
	pq.product_id = clean.product_id

select *
from FinalProductTable
