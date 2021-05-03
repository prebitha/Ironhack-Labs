#1.Get the unique release years
SELECT distinct(f.release_year)
FROM sakila.film f;
#aparently all from 2006?

#2.Get all films with ARMAGEDDON in the title.
SELECT f.film_id, f.title
FROM sakila.film f
WHERE f.title LIKE '%ARMAGEDDON%';
#6 films

#3.Get all films which title ends with APOLLO.
SELECT f.film_id, f.title
FROM sakila.film f
WHERE f.title LIKE '%APOLLO';
#5 films

#4.Get 10 the longest films.
SELECT f.film_id, f.title, f.length
FROM sakila.film f
ORDER BY f.length desc
LIMIT 10;

#5.How many films include Behind the Scenes content?
SELECT count(f.film_id)
FROM sakila.film f
WHERE f.special_features LIKE '%Behind the Scenes%';
#538

#6.Drop column picture from staff.
ALTER table sakila.staff
DROP column picture;

#7.A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT c.customer_id, c.first_name, c.last_name
FROM sakila.customer c
WHERE c.first_name = 'TAMMY' AND c.last_name = 'SANDERS';
#her customer ID is 75

SELECT *
FROM sakila.customer c
WHERE c.customer_id = 75;
#having a look at her data

SELECT *
FROM sakila.staff c;

INSERT into sakila.staff
VALUES ('3','TAMMY','SANDERS','79','TAMMY.SANDERS@sakilastaff.org','2','1','Tammy','1234', '2021-04-06 15:53:00');

SELECT *
FROM sakila.staff c;

#8.Add a rental for movie "Academy Dinosaur" by the customer "Charlotte Hunter" from employee Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information in other tables. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
#Use similar method to get inventory_id, film_id, and staff_id.

#rental_id of Academy Dinosaur
SELECT r.rental_id
FROM sakila.rental r
Order by r.rental_id DESC;
#latest is 16049 so we should use 16050

#rental_date - current date
SELECT Curdate();

#inventory_id - newest
SELECT i.inventory_id
FROM sakila.inventory i
Order by i.inventory_id DESC;
#latest is 4581 so we should use 4582

#customer_id of Charlotte Hunter
SELECT c.customer_id
FROM sakila.customer c
WHERE first_name = 'Charlotte' AND last_name = 'Hunter';
#130

#return_date - open
SELECT f.title, f.rental_duration
FROM sakila.film f
WHERE f.title = 'Academy Dinosaur';

#rental duration 6days
SELECT date_add(day,6,curdate()) as return_date;
#dont know why this is not working, maybe curdate has not the right format to add days?
SELECT date_add(curdate(),interval 6 day) as return_date;
#now it works

#staff_id of Mike Hill
SELECT s.staff_id
FROM sakila.staff s
WHERE first_name = 'Mike';
#1

#last_update - current date

INSERT into sakila.rental (rental_id,rental_date,inventory_id,customer_id,return_date,staff_id,last_update)
VALUES (16050,'2021-04-06 17:09:00',4582,130,'2021-04-12 00:00:00',1,'2021-04-06 17:09:00');

INSERT INTO sakila.rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (99999999, '2005-05-24 22:53:30', 3, 130, '2005-05-26 22:04:30',1, '2005-05-26 22:04:30');
#hm I get an error, I think it has something to do with the keys inventory and rental id
#i guess i have to link them somehow with a key

#right click to table rental "copy to clipboard" insert statement to see how it should be enteres
INSERT INTO `sakila`.`rental`
(`rental_id`,
`rental_date`,
`inventory_id`,
`customer_id`,
`return_date`,
`staff_id`,
`last_update`)
VALUES
(<{rental_id: }>,
<{rental_date: }>,
<{inventory_id: }>,
<{customer_id: }>,
<{return_date: }>,
<{staff_id: }>,
<{last_update: CURRENT_TIMESTAMP}>);

#and same with creat statement to see where there are constraints in keys etc
CREATE TABLE `rental` (
  `rental_id` int(11) NOT NULL AUTO_INCREMENT,
  `rental_date` datetime NOT NULL,
  `inventory_id` mediumint(8) unsigned NOT NULL,
  `customer_id` smallint(5) unsigned NOT NULL,
  `return_date` datetime DEFAULT NULL,
  `staff_id` tinyint(3) unsigned NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rental_id`),
  UNIQUE KEY `rental_date` (`rental_date`,`inventory_id`,`customer_id`),
  KEY `idx_fk_inventory_id` (`inventory_id`),
  KEY `idx_fk_customer_id` (`customer_id`),
  KEY `idx_fk_staff_id` (`staff_id`),
  CONSTRAINT `fk_rental_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_rental_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_rental_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100000000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


#9.
SELECT *
FROM sakila.customer
WHERE active = 0;

CREATE TABLE if not exists delete_users(
`customer_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
 `email` varchar(50) DEFAULT NULL,
 `create_date` datetime NOT NULL);
 
CREATE TABLE `customer` (
  `customer_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `store_id` tinyint(3) unsigned NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address_id` smallint(5) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `create_date` datetime NOT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  KEY `idx_fk_store_id` (`store_id`),
  KEY `idx_fk_address_id` (`address_id`),
  KEY `idx_last_name` (`last_name`),
  CONSTRAINT `fk_customer_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_store` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=600 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO deleted_users
select customer_id, email, curdate()
from
where