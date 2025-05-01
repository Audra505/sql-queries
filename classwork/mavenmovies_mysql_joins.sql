-- JOINS FUNCTION
SELECT * 
FROM  actor;


SELECT         DISTINCT i.inventory_id
FROM           inventory  i 
INNER JOIN     rental     r
ON             i.inventory_id = r.inventory_id;

SELECT		DISTINCT i.inventory_id, r.inventory_id
FROM		inventory i
INNER JOIN	rental r
ON			i.inventory_id = r.inventory_id;

-- Classwork on INNER JOIN
/*Can you pull for me a list of each film we have in inventory?
I would like to see the film's title, description, and the store_id
value associated with each item, and its inventory_id. Thanks*/


SELECT * 
FROM  inventory;

SELECT		i.inventory_id, f.title, f.description, i.store_id  
FROM 		inventory i
INNER JOIN	film f
ON			i.film_id = f.film_id;

SELECT *
FROM      customer; 

SELECT *
FROM      address;

SELECT			c.first_name, c.last_name, c.email, a.address, c.store_id
FROM			address a 
INNER JOIN		customer c
ON				c.address_id = a.address_id;

-- LEFT JOIN

SELECT         DISTINCT i.inventory_id, r.inventory_id
FROM           inventory  i 
LEFT JOIN      rental     r
ON             i.inventory_id = r.inventory_id
WHERE          r.inventory_id IS NULL;


SELECT    * 
FROM      actor;

SELECT    * 
FROM      film_actor;

SELECT    * 
FROM      film;

SELECT			CONCAT(a.first_name, ' ', a.last_name) 'Actor Name', COUNT(fa.film_id) AS 'No of films'
FROm			actor a
LEFT JOIN		film_actor fa
ON				a.actor_id = fa.actor_id
GROUP BY		a.first_name, a.last_name;

-- Classwork on LEFT JOIN
/*How many actors are listed for each film title?
Can you pull a list of all titles, and figure out how many actors
are associated with each title?*/

SELECT			f.film_id, f.title, COUNT(fa.actor_id) AS '# of Actors'
FROM			film       f
LEFT JOIN		film_actor fa
ON				f.film_id = fa.film_id
GROUP BY		f.film_id, f.title;

-- FULL JOIN ********* (REVISIT)

SELECT *
FROM     customer;

SELECT *
FROM     store;

SELECT *
FROM     address;


SELECT			c.first_name, c.last_name, a.address
FROM			address a
JOIN			customer c
ON				c.address_id = a.address_id;

-- Bridging (Unrelated Table) 
SELECT		CONCAT(cu.first_name, ' ', cu.last_name) 'Customer Name', ad.address, ci.city, ad.postal_code, co.country
FROM		Customer cu
INNER JOIN 	address ad
ON			cu.address_id = ad.address_id
INNER JOIN	city ci
ON			ad.city_id = ci.city_id
INNER JOIN	country co 
ON			ci.country_id = co.country_id
AND		    country = 'United States';


-- UNION

SELECT			*
FROM			advisor;

SELECT			*
FROM 			investor;

SELECT			advisor_id 'Executive ID', first_name, last_name
FROM			advisor
UNION ALL
SELECT			investor_id 'Executive ID', first_name, last_name
FROM 			investor;