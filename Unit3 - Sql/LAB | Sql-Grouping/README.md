### LAB SQL GROUPING

:rabbit: 

- [X] Droping Recurring last name:

created a temporary table and fed in the statement and then droped the temp table.
CREATE TEMPORARY TABLE temp
  SELECT   last_name
  FROM     actor
  GROUP BY last_name
  HAVING   COUNT(*) > 1;
DELETE FROM actor WHERE last_name IN (SELECT last_name FROM temp);
DROP TEMPORARY TABLE temp;

 - [X] the keys having more than 1 count

SELECT last_name, count(*) 
FROM actor ;

- [X] rentals processed by staffs 1,2

select count(staff_id) as rental_processed
from rental
group by staff_id;

- [X] no of release in each year

select release_year, count(*) as number_of_release from film 
group by release_year;

- [X] no of rating

select rating, count(*) as number_of_rating from film 
group by rating ;
