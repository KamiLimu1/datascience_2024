-- SQLite
-- SELECT <expressions>
-- FROM <tables>
-- JOIN <to other table> ON <join condition>
-- WHERE <predicates>
-- GROUP BY <expressions>
-- HAVING <predicate>
-- ORDER BY <expressions>
-- LIMIT <number of rows>

-- Basic commands
SELECT * FROM actor;
SELECT first_name, last_name FROM actor;
INSERT INTO actor (first_name, last_name) VALUES ('Sidney', 'Ochieng');
UPDATE actor SET first_name = 'Angela' WHERE actor_id = 1;
DELETE FROM actor WHERE actor_id = 1;
SELECT film.title, category.name
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id;
SELECT actor.first_name, actor.last_name, film.title
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id;
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
SELECT category.name, COUNT(film.film_id) AS film_count
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
HAVING COUNT(film.film_id) > 50;
SELECT title AS name FROM film
UNION
SELECT last_name AS name FROM actor;
SELECT title, category.name, length,
       ROW_NUMBER() OVER (PARTITION BY category.name ORDER BY length DESC) AS row_num
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id;
WITH AvgLength AS (
    SELECT category_id, AVG(length) AS avg_length
    FROM film
    GROUP BY category_id
)
SELECT category.name, AvgLength.avg_length
FROM AvgLength
INNER JOIN category ON AvgLength.category_id = category.category_id;

-- SELECT <expressions>
-- FROM <tables>
-- JOIN <to other table> ON <join condition>
-- WHERE <predicates>
-- GROUP BY <expressions>
-- HAVING <predicate>
-- ORDER BY <expressions>
-- LIMIT <number of rows>
SELECT * FROM address;
SELECT
	address_id 
	,address, 
	city_id, 
	postal_code, 
	last_update
FROM address;
selEct * from staff;
SELECT datetime('now');
INSERT into 
staff (first_name, last_name, email, staff_id, address_id, store_id, active, username, last_update) 
Values ('Angela', 'Kinoro', 'k.a@sakilastaff.com', 4, 1, 1, 1, 'kinoro', datetime('now'));
DELETE FROM staff  WHERE staff_id=4;

SELECT film.title, category.name
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id;


SELECT f.title, c.name 
FROM film AS  f
LEFT JOIN film_category AS fc
	ON f.film_id = fc.film_id 
LEFT JOIN category c 
	ON fc.category_id = c.category_id;
	

SELECT 
	AVG(rental_duration) avg_rental_duration,
	sum(rental_duration) sum_rental_duration,
	count(DISTINCT (rental_duration)) count_rental_duration,
	min(rental_duration),
	max(rental_duration)
FROM film f;

SELECT 
	c.name,
	AVG(f.rental_duration) avg_rental_duration,
	sum(f.rental_duration) sum_rental_duration,
	count(DISTINCT (f.rental_duration)) count_rental_duration,
	min(f.rental_duration),
	max(f.rental_duration)
FROM film AS  f
LEFT JOIN film_category AS fc
	ON f.film_id = fc.film_id 
LEFT JOIN category c 
	ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_rental_duration DESC
LIMIT 10
;


SELECT 
	c.name,
	AVG(f.rental_duration) avg_rental_duration,
	sum(f.rental_duration) sum_rental_duration,
	count(DISTINCT (f.rental_duration)) count_rental_duration,
	min(f.rental_duration),
	max(f.rental_duration)
FROM film AS  f
LEFT JOIN film_category AS fc
	ON f.film_id = fc.film_id 
LEFT JOIN category c 
	ON fc.category_id = c.category_id
WHERE c.category_id >5
GROUP BY c.name
HAVING avg_rental_duration > 5;

SELECT f.title , f.description , f.rental_rate
FROM film f 
WHERE rental_rate < 
(
	SELECT AVG(rental_rate) FROM film f2 
);

WITH average_rental AS (
	SELECT avg(rental_rate), replacement_cost 
	FROM film f 
	GROUP BY f.replacement_cost
),
replacement AS (
 SELECT replacement_cost, sum(rental_rate)
 FROM film f
 GROUP BY f.replacement_cost
)
SELECT 
FROM replacement r
LEFT JOIN average_rental a 
	ON r.replacement_cost = a.replacement_cost;


SELECT 
	title , "length", rating ,
	DENSE_RANK () OVER (PARTITION BY rating ORDER BY "length" desc) AS row_num
FROM film f 
ORDER BY rating, "length" desc ;
	
