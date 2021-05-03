
#Using multiple JOIN() clauses display the store ID, city, and country of each store.
SELECT s.store_id, ci.city, co.country
FROM sakila.store as s
JOIN sakila.address as a
ON s.address_id = a.address_id
JOIN sakila.city as ci
ON a.city_id = ci.city_id
JOIN sakila.country as co
ON ci.country_id = co.country_id;

#Display the total payment amount for each store.
SELECT s.store_id, sum(p.amount)
FROM sakila.payment as p
JOIN sakila.staff as st
ON p.staff_id = st.staff_id
JOIN sakila.store as s
ON st.store_id = s.store_id
GROUP BY s.store_id;

#What is the average film length per each category? Which category of films are the longest?
SELECT c.name as category, round(avg(f.length),2) as avg_length
FROM sakila.film as f
JOIN sakila.film_category as fc
ON f.film_id = fc.film_id
JOIN sakila.category as c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg(f.length) DESC;

#Display the 2 most frequently rented movies in descending order.
SELECT f.title as film, count(r.rental_id) as rental_frequency
FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY count(r.rental_id) DESC
LIMIT 2;

#Display the top 5 categories with highest revenue (payment amount) in descending order.
SELECT c.name as category, round(sum(p.amount),2) as revenue
FROM sakila.category as c
JOIN sakila.film_category as fc
ON c.category_id = fc.category_id
JOIN sakila.film as f
ON fc.film_id = f.film_id
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
JOIN sakila.payment as p
ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY sum(p.amount) DESC
LIMIT 5;

#6Is the Academy Dinosaur movie available for rent from Store 1? If yes, display the title, store_id and inventory_id of the available copies of that movie.
SELECT f.title, i.store_id, i.inventory_id
FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1 AND r.return_date IS NOT Null
GROUP BY i.inventory_id;
#if there is a return date, then the movie should be availabel right?
