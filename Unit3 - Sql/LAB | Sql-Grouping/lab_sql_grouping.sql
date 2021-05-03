# Drop recaurring last_name.
CREATE TEMPORARY TABLE temp
  SELECT   last_name
  FROM     actor
  GROUP BY last_name
  HAVING   COUNT(*) > 1;
DELETE FROM actor WHERE last_name IN (SELECT last_name FROM temp);
DROP TEMPORARY TABLE temp;

# the keys having more than 1 count

SELECT last_name, count(*) 
FROM actor ;

# rentals processed by staffs 1,2
select count(staff_id) as rental_processed
from rental
group by staff_id;

# no of release in each year
select release_year, count(*) as number_of_release from film 
group by release_year;

#no of rating
select rating, count(*) as number_of_rating from film 
group by rating ;




