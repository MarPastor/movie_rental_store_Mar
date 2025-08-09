-- *********************************************
-- Evaluacion Final MOD2 - Mar Pastor
-- *********************************************

-- Usando la BBDD Sakila
USE Sakila;

-- *********************************************
-- Ejercicios
-- *********************************************

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados

SELECT DISTINCT f.title -- selecciona la columna con el nombre de las peliculas una vez con 'distinct'
FROM film AS f; -- de la tabla 'film' con un alias 'f'

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"

SELECT f.title, f.rating -- seleccina las columnas con el nombre y la clasificación de las películas
FROM film AS f -- llama la tabla que contiene las columnas con un alias 'f'
WHERE rating = 'PG-13'; -- filtra la información requerida en el ejercicio

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción

SELECT f.title, f.description -- selecciona las columnas de nombre y descripción
FROM film AS f -- de la tabla 'film' con un alias 'f'
WHERE f.description LIKE '%amazing%'; -- filtra las descripciones que contiene la palabra 'amazing' y lo que rodee la palabra

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos

SELECT f.title, f.length -- seleccion el titulo y la duración para comprobar resultados
FROM film AS f -- de la tabla 'film' con un alias 'f'
WHERE f.length > 120 -- filtra las peliculas que tengan una duración mayor de 120
ORDER BY f.length;

-- 5. Recupera los nombres de todos los actores

-- propuesta_solucion_1
SELECT a.first_name, a.last_name -- selecciona las columnas del nombre y apellido de los actores
FROM actor AS a; -- en la tabla 'actor' con alias 'a'

-- propuesta_solucion_2
SELECT a.first_name -- selecciona la columna del nombre de los actores
FROM actor AS a; -- en la tabla 'actor' con un alias 'a'

-- propuesta_solucion_3
SELECT CONCAT(first_name, ' ', last_name) AS actor_name -- selecciona los datos de las columnas nombre y apellidos, y las concatena en una sola columna
FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido

SELECT a.first_name, a.last_name -- selecciona las columnas de nombre y apellidos
FROM actor AS a -- de la tabla 'actor' con un alias 'a'
WHERE a.last_name LIKE '%Gibson%'; -- filtra la consulta con nombre y apellido de actores que contengan 'Gibson' en la columna 'last_name'

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20

SELECT a.first_name, a.actor_id -- selecciona la columna del nombre de los actores y el id de los actores para comprobar resultados
FROM actor AS a -- de la tabla 'actor' con alias 'a'
WHERE a.actor_id BETWEEN 10 AND 20 -- filtra los id de los actores entre 10 y 20, incluyéndolos
ORDER BY a.actor_id; -- ordena por id de mayor a menor

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación

SELECT f.title, f.rating -- selecciona titulo de las columnas del titulo y clasificación para verificación
FROM film AS f -- de la tabla 'film' con alias 'f'
WHERE f.rating NOT IN ('R', 'PG-13') -- filtra la consulta para que no muestre peliculas con clasificación 'R' o "PG-13'
ORDER BY f.rating; -- ordena el rating para mejor visibilización

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento

SELECT f.rating, COUNT(DISTINCT f.title) AS rating_count -- selecciona la clasificación de las peliculas y cuentas las peliculas dentro de esa categoria, guarda los datos en una columna 'recuento'
FROM film AS f -- de la tabla 'film' con alias 'f'
GROUP BY f.rating; -- para que aparezca la lista agrupada por clasificación

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido 
-- junto con la cantidad de películas alquiladas

SELECT r.customer_id, c.first_name, c.last_name, COUNT(DISTINCT r.rental_id) AS rented_movies -- selecciona el ID, nombre completo del cliente y conteo de películas alquiladas
FROM rental AS r -- de la tabla 'film'
INNER JOIN customer AS c ON r.customer_id = c.customer_id -- uniendo la tabla 'customers' usando el 'customer_id'
GROUP BY r.customer_id; -- agrupa la consulta por el 'customer_id'

--  11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres

SELECT c.name, COUNT(r.rental_id) AS rented_count -- selecciona el nombre de la categoría y el recuento veces que se han alguilado
FROM rental AS r -- de la tabla 'rental'
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id -- unida a la tabla 'inventory' usando el 'inventory_id'
INNER JOIN film_category AS fc ON i.film_id = fc.film_id -- unida a su vez a la tabla 'film_category' usando el 'film_id'
INNER JOIN category AS c ON fc.category_id = c.category_id -- unida a su vez a la tabla 'category' usando el 'category_id'
GROUP BY c.name; -- se agrupa con el nombre de la categoría

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración

SELECT c.name, AVG(f.length) -- seleccion el nombre de la clasificación, calculando el promedio de duración de la película
FROM film AS f -- de la tabla 'film'
INNER JOIN film_category AS fc ON f.film_id = fc.film_id -- unida a la tabla 'film_category' usando el 'film_id'
INNER JOIN category AS c ON fc.category_id = c.category_id -- unida a su vez a la tabla 'category' usando el 'category_id'
GROUP BY c.name; -- agrupando la consulta por el nombre de la clasificación

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love"

SELECT a.first_name, a.last_name, f.title -- selecciona el nombre y apellido de actor/actriz, y el nombre de la película 'Indian Love' como comprobación
FROM actor AS a -- de la tabla 'actor'
INNER JOIN film_actor AS fa ON fa.actor_id = a.actor_id -- uniendo la tabla 'film_actor' usando el 'actor_id'
INNER JOIN film AS f ON f.film_id = fa.film_id -- uniendo a su vez la tabla 'film' usando el 'film_id'
WHERE f.title = 'Indian Love'; -- usa un filtro en título de la película para mostrar solo los que actuaron en 'Indian Love'

--  14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción

SELECT f.title, f.description -- selecciona el titulo de la pelicual y la descripción como comprobación
FROM film AS f -- de la tabla 'film'
WHERE f.description LIKE '% dog %' OR f.description LIKE '% cat %'; -- usando patrones que incluyan las palabras 'dog' o 'cat' y muestre resultados de ambos

--  15. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010

SELECT f.title, f.release_year -- selecciona el titulo y el año de estreno como comprobación
FROM film AS f -- de la tabla 'film'
WHERE f.release_year BETWEEN 2005 AND 2010; -- agrega un filtro a la consulta enre los año 2005 y 2010

-- 16. Encuentra el título de todas las películas que son de la misma categoría que "Family"

SELECT f.title, c.name -- selecciona el título de todas las películas y categoría como comprobación
FROM film AS f -- de la tabla 'film'
INNER JOIN film_category AS fc ON f.film_id = fc.film_id -- unida a la tabla 'film_category' por el 'film_id'
INNER JOIN category AS c ON fc.category_id = c.category_id -- unida a su vez a la tabla 'category' por el 'category_id'
WHERE c.name = 'Family'; -- aplica un filtro a la consulta las películas de la categoría "Family"

-- 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film

SELECT f.title, f.rating, f.length -- selecciona el título de todas las películas, rating 'R' y la duración como comprobación
FROM film AS f -- de la tabla 'film'
WHERE f.rating = 'R' AND f.length > 120 -- filtra la consulta por películas con rating "R" y de duración mayor a 2 horas
ORDER BY f.length; -- ordenada por duración

-- *********************************************
-- Ejercicio bonus
-- *********************************************

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS movies_count -- selecciona nombre y apellido de los actores y el conteo de las peliculas en las que aparecen
FROM film_actor AS fa -- de la tabla 'film_actor'
INNER JOIN actor AS a ON fa.actor_id = a.actor_id -- unida con la tabla 'actor' para obtener los nombres y apellidos donde coincidan con el 'actor_id'
GROUP BY fa.actor_id -- agrupa el conteo de peliculas por 'actor_id'
HAVING movies_count > 10 -- filtra la consulta para que muestre los actores que aparecen en más de 10 películas
ORDER BY movies_count; -- ordena por la cantidad de películas de menor a mayor

-- 19. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor?

SELECT actor_id -- seleccion el id del actor/actriz
FROM film_actor -- de la tabla 'film_actor'
WHERE film_id IS NULL; -- verifica si en la columna film_id hay resultados nulos, es decir que no esten en alguna pelicula

--  20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos 
-- y muestra el nombre de la categoría junto con el promedio de duración

SELECT c.name, AVG(f.length) AS average_duration -- selecciona la categoría y la duración
FROM film AS f -- de la tabla 'film'
INNER JOIN film_category AS fc ON f.film_id = fc.film_id -- uniendo con la tabla 'film_category' usando el 'film_id'
INNER JOIN category AS c ON fc.category_id = c.category_id -- uniendo a su vez con la tabla 'category' usando el 'category_id'
GROUP BY c.name -- agrupa la consulta por el nombre de la categoría
HAVING average_duration > 120; -- filtra la consulta que muestre los resultados con un promedio de duración superior a 120

--  21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado

SELECT a.first_name, COUNT(DISTINCT fa.film_id) AS movies -- seleccion el nombre de actor/actriz y el conteo de películas en las que han actuado
FROM actor AS a -- de la tabla 'actor'
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id -- uniendo con la tabla 'film_actor' usando el 'actor_id'
GROUP BY a.first_name -- agrupar la consulta por el nombre de actor/actriz
HAVING movies > 5 -- filtra la consulta que muestre resultados en el conteo mayores a 5
ORDER BY movies; -- ordenar por películas para mejor comprobación

-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días
-- Utiliza unasubconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes

-- subconsulta que encuentra los alquileres mayores a 5 días

SELECT r.rental_id, r.rental_date, r.return_date, DATEDIFF(r.return_date, r.rental_date) AS days_rented -- usa el comando 'datediff' para calcular los dias entre fechas
FROM rental AS r
HAVING days_rented > 5; -- filtra los resultados para mostrar los mayores a 5 días

-- pero para usarlo con la consulta principal podemos poner la función 'DATEDIFF' como una condicional, ya que la subconsulta acepta seleccionar una sola columna

SELECT r.rental_id
FROM rental AS r
WHERE DATEDIFF(r.return_date, r.rental_date) > 5; -- usar el DATEDIFF resultado en el filtro como condición
                  
-- unir a la consulta principal (Encuentra el título de todas las películas que fueron alquiladas por más de 5 días)

SELECT DISTINCT f.title -- selecciona el título de todas las películas sin que se repita
FROM film AS f -- de la tabla 'film'
INNER JOIN inventory AS i USING(film_id) -- uniendo con la tabla 'inventory' usando el 'film_id'
INNER JOIN rental AS r USING(inventory_id) -- uniendo con la tabla 'rental' usando el 'inventory_id'
WHERE f.film_id IN (SELECT r.rental_id -- aplicando el filtro de la consulta por el 'film_id' que cumpla con el resultado de la subconsulta
				  FROM rental AS r -- de la tabla 'rental'
                  INNER JOIN inventory AS i USING(inventory_id) -- uniendo con la tabla 'inventory' usando el 'inventory_id'
                  INNER JOIN film AS F USING(film_id) -- uniendo con la tabla 'film' usando el 'film_id'
				  WHERE DATEDIFF(r.return_date, r.rental_date) > 5 -- usando un filtro que tome los resultados que cumpla con la diferencia entre fecha de renta y fecha de devolución de la película
                  );

-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror"
-- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores

-- subconsulta para conseguir actor/actriz que actuaron en películas de la categoría "Horror"

SELECT a.first_name, a.last_name, c.name -- selecciona el nombre, apellido y la categoría
FROM actor AS a -- de la tabla 'actor'
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id -- unir con la tabla 'film_actor' usando el actor_id
INNER JOIN film_category AS fc ON fa.film_id = fc.film_id -- unir con la tabla 'film_category' usando el film_id
INNER JOIN category AS c ON fc.category_id = c.category_id -- unir con la tabla 'category' usando el category_id
WHERE c.name = 'Horror'; -- filtrar el resultado por actor/actriz que actuaron en películas de la categoría "Horror"

-- consulta principal que excluye actor/actriz de la lista de la subconsulta usando NOT IN en el filtro del resultado

SELECT DISTINCT CONCAT(a.first_name, ' ', a.last_name) AS actor_name, c.name -- usando CONCAT para crear una columna con el nombre completo del actor/actriz
FROM actor AS a
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

-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film
 
SELECT f.title, c.name, f.length -- selecciona el título de las películas, la categoría y la duración para comprobación
FROM film AS f -- de la tabla 'film'
INNER JOIN film_category AS fc USING(film_id) -- unida a la tabla 'film' usando el 'film_id'
INNER JOIN category AS c USING(category_id) -- unida a la tabla 'category' usando el 'category_id'
WHERE c.name = 'Comedy' -- filtra los resultados por la categoría comedia
AND f.length > 180 -- filtra por la duración mayor a 180 minutos
ORDER BY f.length; -- ordena por duración
 
-- 25. Encuentra todos los actores que han actuado juntos en al menos una película
-- La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos

SELECT a.first_name, a.last_name, COUNT(film_id) AS films_acted_together, GROUP_CONCAT(film_id) AS film_ad_group -- selecciona nombre, apellido y el número de películas en las que han actuado juntos, usa GROUP_CONCAT apra verificar el resultado
FROM actor AS a -- de la tabla 'actor'
INNER JOIN film_actor AS fa USING(actor_id) -- unida a la tabla 'film_actor'
GROUP BY a.actor_id -- agrupada por 'actor_id'
ORDER BY films_acted_together; -- organiza de menor a mayor