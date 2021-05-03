#Select all actors with first name 'Scarlett'
select * from actor where first_name = 'Scarlett';
#How many films are available for rent
select count(title) from film;
#how many films have been rented
select count(rental_id) from rental;
#What are the shortest and longest movie duration? 
select length ,count(*) from film group by length order by length DESC;
# Name the values max_duration and min_duration.
select length as max_duration from film where length='185';
select length as min_duration from film where length='46';
#What's the average movie duration expressed in format (hours, minutes)?
select avg(length) from film;
SELECT TIME_FORMAT(avg(length), '%Hh:%im') as time FROM film;
#How many distinct (different) actors' last names are there?
select last_name, count(*) from actor;
#Since how many days has the company been operating (check DATEDIFF() function)?
select rental_date,datediff() from rental;
#Show rental info with
#additional columns month and weekday. Get 20 results.
select dayname(rental_date) , weekday(rental_date) from rental
