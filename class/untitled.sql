--1- Create a student record with the following attributes: first_name: John, last_name: Smith, Age: 45, email: john@smith.com registration_date: January 1st 2016, phone_number: 778.778.7787
insert into students (first_name,last_name,age,email,registration_date,phone_number,created_at,updated_at) values('John','Smith',45,'john@smith.com',now(),'778.778.7787',now(),now());
2016-10-03 20:30:36.046966
	--

	insert into students (first_name,last_name,age,email,registration_date,phone_number,created_at,updated_at) values('John','Smith',45,'john@smith.com','2016-01-01 20:30:36.046966','778.778.7787',now(),now());

--2- Select that student from the database be fetching the last record
select * from students order by created_at desc limit 1;

--3- Using the id you fetched from the previous exercise, update the age of that record to become 50
update students set age=50 where id=(select id from students order by created_at desc limit 1);

--4- Delete that record using its id
delete from students where id=(select id from students order by created_at desc limit 1);

	
-- Write the following SQL Queries:

-- From the students table:
-- 1- Select the first 10 students whose ages are between 35 and 45
select * from students where age between 35 and 45 limit 10
-- 2- Select the third set of 10 students whose ages are more than 25 and whose first names contain `th`. The students must be ordered by their id then first name in a descending order.
select * from students where age>25 and first_name ilike '%th%' order by id,first_name offset 20 limit 10;

-- 3- Select the 10 oldest students (You should ignore students with an age that is `NULL`)
select * from students order by age desc limit 10;
-- 4- Select all students with age 45 whose last names contain the letter n
select * from students where age=45 and last_name ilike '%n%';

-- From the products table:
-- 5- Select all the products that are on sale
-- id	name	description	price	sale_price	remaining_quantity	created_at	updated_at
select * from products where (sale_price!=price);

-- 6- Select all the products that are on sale and have remaining items in stock ordered by the sale price in ascending order
select * from products where (sale_price!=price) and remaining_quantity>0 order by sale_price asc;


-- 7- Select all the products priced between 25 and 50 (regular price) and that are on sale
select * from products where (sale_price!=price) and price between 25 and 50;

-- From the students table:
-- 1- Find the number of students named 'Milton'.
select count(*) from students where first_name='Milton';
-- 2- List the `first_name`s that occur more than once in students, with the number occurrences of that name.
select first_name, count(*) from students group by first_name

select t.first_name,t.count from (select first_name, count(*) from students group by first_name)t where t.count>2;

-- 3- Refine the above query to list the 20 most common first_names among students, in order first of how common they are, and alphabetically when names have the same count.
select t.first_name,t.count from (select first_name, count(*) from students group by first_name)t order by count desc limit 20;


-- From the products table:
-- 1- Find the most expensive product
select * from products order by price desc limit 1;
-- 2- Find the cheapest product that is on sale
select * from (select * from products where sale_price!=price)t order by t.price asc limit 1;

-- 3- Find the total value of all inventory in stock (use sale price)
select sum(remaining_quantity*sale_price) from products


-- For the products table:
-- id	name	description	price	sale_price	remaining_quantity	created_at	updated_at
-- 1- Select the product whose stock has the most value (use sale price)
select name, sum(sale_price*remaining_quantity) from products group by name order by sum desc

-- 2- Select the most expensive product whose price is between 25 and 50 with remaining quantity
select * from products where price between 25 and 50 and remaining_quantity>0 order by price desc limit 1

-- 3- Select all products on sale with remaining quantity ordered by their price and then their name
select * from products where price!=sale_price and remaining_quantity>0 order by price,name;


-- 4- Select the second set 20 results based on the previous query
select t.* from (select * from products where price!=sale_price and remaining_quantity>0 order by price,name
)t offset 20 limit 20;

-- 5- Find the average price of all products
select avg(price) from products;

-- 6- Find the average price of all products that are on sale
select avg(price) from products where sale_price!=price;

-- 7- Find the average price of all products that are on sale with remaining quantity
select avg(price) from products where sale_price!=price and remaining_quantity>0

-- 8- Update all the products whose name contains `paper` (case insensitive) to have a remaining quantity of 0
update products set remaining_quantity=0 where name ilike '%paper%'

-- 9- Is it possible to revert the query in question 8?

-- 10- Update all the products whose name contains `paper` or `steel` to have a remaining quantity of a random number between 5 and 25

update  products set remaining_quantity=random()*20+5 where name ilike '%paper%' or name ilike '%steel%';

-- 11- Select the second set of 10 cheapest products with remaining quantity
select * from products where remaining_quantity>0 offset 10 limit 10;

-- 12- Build a query that groups the products by their sale price and show the number of products in that price and the sum of remaining quantity. Label the count `product_count`
select count(*),sum(remaining_quantity) as product_count from products group by sale_price;


-- 13- [stretch] Update the most expensive product to have double its quantity in a single query
update products set remaining_quantity =remaining_quantity*2 order by price desc limit 1
