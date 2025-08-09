-- *********************************************
-- Movie Rental Database
-- *********************************************

-- Using BBDD Sakila
USE Sakila;

-- *********************************************
-- Querys
-- *********************************************

-- 1. Select all movie names without duplicates appearing

SELECT DISTINCT f.title -- select the column with the movie names once with 'distinct'
FROM film AS f; -- from the 'film' table with an alias 'f'

-- 2. Displays the names of all movies that have a "PG-13" rating

SELECT f.title, f.rating -- select the columns with the name and rating of the movies
FROM film AS f -- from 'film' table containing the columns with an alias 'f'
WHERE rating = 'PG-13'; -- filters the information required in the exercise

-- 3. Find the title and description of all movies that contain the word "amazing" in their description

SELECT f.title, f.description -- select the name and description columns
FROM film AS f -- from the 'film' table with an alias 'f'
WHERE f.description LIKE '%amazing%'; -- filters descriptions that contain the word 'amazing' and what surrounds the word

-- 4. Find the title of all movies that are longer than 120 minutes

SELECT f.title, f.length -- select the title and duration to check the results
FROM film AS f -- from the 'film' table with an alias 'f'
WHERE f.length > 120 -- filter movies that are longer than 120
ORDER BY f.length;

-- 5. Select the names of all actors

-- proposed_solution_1
SELECT a.first_name, a.last_name -- select the actors' first and last name columns
FROM actor AS a; -- in the 'actor' table with alias 'a'

-- proposed_solution_2
SELECT a.first_name -- select the actors' name column
FROM actor AS a; -- in the 'actor' table with an alias 'a'

-- proposed_solution_3
SELECT CONCAT(first_name, ' ', last_name) AS actor_name -- selects the data from the first and last name columns and concatenates them into a single column
FROM actor;

-- 6. Find the first and last names of actors who have "Gibson" in their last name

SELECT a.first_name, a.last_name -- select the first and last name columns
FROM actor AS a -- from the 'actor' table with an alias 'a'
WHERE a.last_name LIKE '%Gibson%'; -- filter the query with the first and last name of actors that contain 'Gibson' in the 'last_name' column

-- 7. Find the names of actors that have an actor_id between 10 and 20

SELECT a.first_name, a.actor_id -- select the actor name and actor id column to check the results
FROM actor AS a -- from the 'actor' table with an alias 'a'
WHERE a.actor_id BETWEEN 10 AND 20 -- filters actor ids between 10 and 20, including them
ORDER BY a.actor_id; -- sort by id from highest to lowest

-- 8. Find the title of the movies in the film table that are neither "R" nor "PG-13" in terms of their classification

SELECT f.title, f.rating -- select title from title and sort columns for verification
FROM film AS f -- from the table 'film' with alias 'f'
WHERE f.rating NOT IN ('R', 'PG-13') -- filter the query to not show movies with an 'R' or 'PG-13' rating
ORDER BY f.rating; -- sort the rating for better visibility

-- 9. Find the total number of movies in each rating in the film table and display the rating along with the count

SELECT f.rating, COUNT(DISTINCT f.title) AS rating_count -- select the movie classification and count the movies within that category, saving the data in a 'count' column
FROM film AS f -- from the table 'film' with alias 'f'
GROUP BY f.rating; -- to display the list grouped by classification

-- 10. Find the total number of movies rented by each customer and display the customer ID, first name, and last name
-- along with the number of movies rented

SELECT r.customer_id, c.first_name, c.last_name, COUNT(DISTINCT r.rental_id) AS rented_movies -- select the customer's ID, full name, and rental movie count
FROM rental AS r -- from the table 'rental' with alias 'r'
INNER JOIN customer AS c ON r.customer_id = c.customer_id -- joining the 'customers' table using the 'customer_id'
GROUP BY r.customer_id; -- groups the query by the 'customer_id'

--  11. Find the total number of movies rented by category and display the category name along with the rental count

SELECT c.name, COUNT(r.rental_id) AS rented_count -- select the category name and the number of times it has been rented
FROM rental AS r -- from the table 'rental' with alias 'r'
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id -- joined to the 'inventory' table using the 'inventory_id'
INNER JOIN film_category AS fc ON i.film_id = fc.film_id -- joined in turn to the 'film_category' table using the 'film_id'
INNER JOIN category AS c ON fc.category_id = c.category_id -- joined in turn to the 'category' table using the 'category_id'
GROUP BY c.name; -- is grouped with the category name

-- 12. Find the average length of the movies for each rating in the film table and display the rating along with the average length

SELECT c.name, AVG(f.length) -- select the name of the rating, calculating the average length of the film
FROM film AS f -- from the table 'film' with alias 'f'
INNER JOIN film_category AS fc ON f.film_id = fc.film_id -- joined to the 'film_category' table using the 'film_id'
INNER JOIN category AS c ON fc.category_id = c.category_id -- joined in turn to the 'category' table using the 'category_id'
GROUP BY c.name; -- grouping the query by the classification name

-- 13. Find the first and last names of the actors who appear in the film titled "Indian Love"

SELECT a.first_name, a.last_name, f.title -- select the actor/actress's first and last name, and the movie name 'Indian Love' as a check.
FROM actor AS a -- from the 'actor' table with an alias 'a'
INNER JOIN film_actor AS fa ON fa.actor_id = a.actor_id -- joining the 'film_actor' table using the 'actor_id'
INNER JOIN film AS f ON f.film_id = fa.film_id -- joining the 'film' table using the 'film_id'
WHERE f.title = 'Indian Love'; -- use a filter on the movie title to show only those who acted in 'Indian Love'

--  14. Displays the title of all movies that contain the word "dog" or "cat" in their description

SELECT f.title, f.description -- select the movie title and description as verification
FROM film AS f -- from the table 'film' with alias 'f'
WHERE f.description LIKE '%dog%' OR f.description LIKE '%cat%'; -- using patterns that include the words 'dog' or 'cat' and show results for both

--  15. Find the titles of all the movies that were released between 2005 and 2010

SELECT f.title, f.release_year -- select the title and year of release as verification
FROM film AS f -- from the table 'film' with alias 'f'
WHERE f.release_year BETWEEN 2005 AND 2010; -- add a filter to the query between the years 2005 and 2010

-- 16. Find the titles of all movies that are in the same category as "Family"

SELECT f.title, c.name -- select the title of all movies and category as a check
FROM film AS f -- from the table 'film' with alias 'f'
INNER JOIN film_category AS fc ON f.film_id = fc.film_id -- joined to the 'film_category' table by the 'film_id'
INNER JOIN category AS c ON fc.category_id = c.category_id -- joined in turn to the 'category' table by the 'category_id'
WHERE c.name = 'Family'; -- apply a filter to the query for movies in the "Family" category

-- 17. Find the title of all movies that are "R" and have a runtime greater than 2 hours in the film table

SELECT f.title, f.rating, f.length -- select the title of all movies, the 'R' rating, and the duration as a check
FROM film AS f -- from the table 'film' with alias 'f'
WHERE f.rating = 'R' AND f.length > 120 -- filter the query by movies with an "R" rating and running time greater than 2 hours
ORDER BY f.length; -- sorted by duration

-- *********************************************
-- More Complex Queries
-- *********************************************

-- 18. Displays the first and last names of actors who appear in more than 10 films

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS movies_count -- select the actors' first and last names and the count of the films in which they appear
FROM film_actor AS fa -- from the 'film_actor' table with an alias 'fa'
INNER JOIN actor AS a ON fa.actor_id = a.actor_id -- joined with the 'actor' table to obtain the first and last names where they match the 'actor_id'
GROUP BY fa.actor_id -- group the movie count by 'actor_id'
HAVING movies_count > 10 -- filter the query to show actors who appear in more than 10 movies
ORDER BY movies_count; -- sort by number of movies from lowest to highest

-- 19. Is there any actor or actress who doesn't appear in any film in the film_actor table?

SELECT actor_id -- select the actor/actress id
FROM film_actor -- from the 'film_actor'
WHERE film_id IS NULL; -- check if there are null results in the film_id column, that is, if they are not in any movie

--  20. Find movie categories that have an average length of more than 120 minutes
-- and displays the category name along with the average duration

SELECT c.name, AVG(f.length) AS average_duration -- select the category and duration
FROM film AS f -- from the table 'film' with alias 'f'
INNER JOIN film_category AS fc ON f.film_id = fc.film_id -- joining with the 'film_category' table using the 'film_id'
INNER JOIN category AS c ON fc.category_id = c.category_id -- joining in turn with the 'category' table using the 'category_id'
GROUP BY c.name -- groups the query by category name
HAVING average_duration > 120; -- filter the query to show results with an average duration greater than 120

--  21. Find actors who have acted in at least 5 movies and display the actor's name along with the number of movies they have acted in

SELECT a.first_name, COUNT(DISTINCT fa.film_id) AS movies -- select the name of the actor/actress and the number of films they have acted in
FROM actor AS a -- from the table 'actor' with alias 'a'
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id -- joining with the 'film_actor' table using the 'actor_id'
GROUP BY a.first_name -- group the query by the actor/actress name
HAVING movies > 5 -- filter the query that shows results in the count greater than 5
ORDER BY movies; -- sort by movies for better verification

-- 22. Find the title of all movies that were rented for more than 5 days
-- Use a subquery to find rental_ids with a duration greater than 5 days and then select the corresponding movies

-- subquery that finds rentals longer than 5 days

SELECT r.rental_id, r.rental_date, r.return_date, DATEDIFF(r.return_date, r.rental_date) AS days_rented -- use the 'datediff' command to calculate the days between dates
FROM rental AS r -- from the table 'rental' with alias 'r'
HAVING days_rented > 5; -- filter the results to show those older than 5 days

-- but to use it with the main query we can put the 'DATEDIFF' function as a conditional, since the subquery accepts selecting only one column

SELECT r.rental_id
FROM rental AS r -- from the table 'rental' with alias 'r'
WHERE DATEDIFF(r.return_date, r.rental_date) > 5; -- use the DATEDIFF result in the filter as a condition
                  
-- join to main query (Find the titles of all movies that have been rented for more than 5 days)

SELECT DISTINCT f.title -- select the title of all movies without repeating it
FROM film AS f -- from the table 'film' with alias 'f'
INNER JOIN inventory AS i USING(film_id) -- joining with the 'inventory' table using the 'film_id'
INNER JOIN rental AS r USING(inventory_id) -- joining with the 'rental' table using the 'inventory_id'
WHERE f.film_id IN (SELECT r.rental_id -- applying the query filter by the 'film_id' that meets the result of the subquery
				  FROM rental AS r -- from the table 'rental' with alias 'r'
                  INNER JOIN inventory AS i USING(inventory_id) -- joining with the 'inventory' table using the 'inventory_id'
                  INNER JOIN film AS F USING(film_id) -- joining with the 'film' table using the 'film_id'
				  WHERE DATEDIFF(r.return_date, r.rental_date) > 5 -- using a filter that takes the results that meet the difference between the rental date and the return date of the movie
                  );

-- 23. Find the first and last names of actors who have not acted in any film in the "Horror" category.
-- Use a subquery to find actors who have acted in films in the "Horror" category and then exclude them from the cast list

-- subquery to find actors/actresses who acted in films in the "Horror" category

SELECT a.first_name, a.last_name, c.name -- select the first name, last name and category
FROM actor AS a -- from the table 'actor' with alias 'a'
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id -- join with the 'film_actor' table using the actor_id
INNER JOIN film_category AS fc ON fa.film_id = fc.film_id -- join with the 'film_category' table using the film_id
INNER JOIN category AS c ON fc.category_id = c.category_id -- join with the 'category' table using the category_id
WHERE c.name = 'Horror'; -- filter the result by actor/actress who acted in films in the "Horror" category

-- main query that excludes actor/actress from the subquery list using NOT IN in the result filter

SELECT DISTINCT CONCAT(a.first_name, ' ', a.last_name) AS actor_name, c.name -- using CONCAT to create a column with the actor's/actress's full name
FROM actor AS a -- from the table 'actor' with alias 'a'
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN film_category AS fc ON fa.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
WHERE a.actor_id NOT IN (SELECT a.actor_id
						FROM actor AS a
						INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
						INNER JOIN film_category AS fc ON fa.film_id = fc.film_id
						INNER JOIN category AS c ON fc.category_id = c.category_id
						WHERE c.name = 'Horror')
ORDER BY c.name;

-- 24. Find the title of comedies that are longer than 180 minutes in the film table
 
SELECT f.title, c.name, f.length -- select the movie title, category and duration for checking
FROM film AS f -- from the table 'film' with alias 'f'
INNER JOIN film_category AS fc USING(film_id) -- joined to the 'film' table using the 'film_id'
INNER JOIN category AS c USING(category_id) -- joined to the 'category' table using the 'category_id'
WHERE c.name = 'Comedy' -- filter the results by the comedy category
AND f.length > 180 -- filter by duration greater than 180 minutes
ORDER BY f.length; -- sort by duration
 
-- 25. Find all the actors who have acted together in at least one movie
-- The query must show the actors' first and last names and the number of films they have acted in together

SELECT a.first_name, a.last_name, COUNT(film_id) AS films_acted_together, GROUP_CONCAT(film_id) AS film_ad_group -- select first name, last name, and the number of films they have acted in together. Use GROUP_CONCAT to verify the result.
FROM actor AS a -- from the 'actor' table with an alias 'a'
INNER JOIN film_actor AS fa USING(actor_id) -- joined to the 'film_actor' table
GROUP BY a.actor_id -- grouped by 'actor_id'
ORDER BY films_acted_together; -- organized from smallest to largest