-- Wahyu Tri Utomo
-- Practice SQL
-- Data Fellowship IYKRA

-- 1. A customer wants to know the films about “astronauts”. How many recommendations could you give for him?
SELECT
	count(*)
FROM
	film
WHERE
	description LIKE '%Astronaut%';
-- 2. I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?
SELECT
	count(*)
FROM
	film
WHERE
	rating = 'R'
	AND
	replacement_cost BETWEEN 5 and 15;
-- 3. We have two staff members with staff IDs 1 and 2. 
-- We want to give a bonus to the staff member that handled the most payments.
-- How many payments did each staff member handle? And how much was the total amount processed by each staff member?
-- a. Payment did each staff member handle
SELECT
	CONCAT_WS(' ', s.first_name, s.last_name) as name
	,count(py.amount) as total_payment
	,sum(py.amount) as total_amount
FROM
	payment py
LEFT JOIN
	staff s
ON 
	py.staff_id = s.staff_id
GROUP BY
	name;

-- 4. Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
SELECT
	rating
	,avg(replacement_cost) as avg_replacement_cost
FROM
	film
GROUP BY
	rating;

-- 5. We want to send coupons to the 5 customers who have spent the most amount of money. 
--Get the customer name, email and their spent amount!
SELECT
	CONCAT_WS(' ', cs.first_name, cs.last_name) as name
	,cs.email
	,sum(py.amount) as total_amount
FROM
	customer cs
FULL JOIN
	payment py
ON
	cs.customer_id = py.customer_id
GROUP BY
	name, cs.email
ORDER BY
	total_amount DESC
LIMIT
	5;
	
-- 6. We want to audit our stock of films in all of our stores. How many copies of each movie in each store, do we have?
SELECT
	i.store_id
	,f.title
	,count(i.film_id) as copies
FROM
	inventory  i
FULL JOIN
	film f
ON
	f.film_id = i.film_id
GROUP BY
	i.store_id
	,f.title
ORDER BY
	i.store_id;

-- 7. -	We want to know what customers are eligible for our platinum credit card. 
--The requirements are that the customer has at least a total of 40 transaction payments. 
--Get the customer name, email who are eligible for the credit card!
SELECT
	CONCAT_WS(' ', first_name, last_name) as name
	,cs.email
FROM
	customer cs
FULL JOIN
	payment py
ON
	cs.customer_id = py.customer_id
GROUP BY
	name
	,cs.email
HAVING
	count(py.amount) >= 40;