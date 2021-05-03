

#1.Use the RANK() and the table of your choice rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT f.title, f.length, 
rank() over (order by length desc) as 'rank'
FROM sakila.film f
WHERE f.length <> ' ';
#little weird that it goes, 1,11,19 and not 1,2,3 ...

SELECT f.title, f.length, 
row_number() over (order by length desc) as 'rank'
FROM sakila.film f
WHERE f.length <> ' ';
#this might be an idea 

#2.Build on top of the previous query and rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.
SELECT f.title, f.length, f.rating, 
rank() over (partition by rating order by length desc) as 'rank'
FROM sakila.film f
WHERE f.length <> ' ';

#3.How many films are there for each of the categories? Inspect the database structure and use appropriate join to write this query.
SELECT * 
FROM sakila.category c;
#PK is category_id

#we need table film_category
SELECT * 
FROM sakila.film_category c;
# has FK film_id and category_id

SELECT c.name, count(fc.film_id) as amount_films
FROM sakila.category as c 
JOIN sakila.film_category as fc 
ON c.category_id = fc.category_id
GROUP BY c.name;

#4.Which actor has appeared in the most films?
SELECT a.last_name, count(fa.film_id) as amount_films
FROM sakila.actor as a 
JOIN sakila.film_actor as fa 
ON a.actor_id = fa.actor_id
GROUP BY a.last_name
ORDER BY count(fa.film_id) DESC;
#Kilmer

#5.Most active customer (the customer that has rented the most number of films)
SELECT c.last_name, count(r.rental_id) as amount_rentals
FROM sakila.rental as r 
JOIN sakila.customer as c 
ON c.customer_id = r.customer_id
GROUP BY c.last_name
ORDER BY count(r.rental_id) DESC;
#Hunt

#6.Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
SELECT f.title, count(r.rental_id) as amount_rentals
FROM sakila.rental as r 
JOIN (sakila.inventory as i JOIN sakila.film f ON i.film_id = f.film_id)
ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY count(r.rental_id) DESC;