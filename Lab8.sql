USE sakila;
-- 1.Rank films by length.

select * from film;
select title,length ,rank() over ( order by length desc) as 'Rank'
from sakila.film;

-- 2.Rank films by length within the rating category.
select title,length, rating ,rank() over (partition by rating order by length desc) as 'Rank'
from sakila.film;

-- 3.Rank languages by the number of films (as original language).
select * from film;

select tb.language_id, ta.name AS 'language', count(tb.film_id) AS 'number of films', rank() over (partition by name order by count(tb.film_id) DESC) as 'Rank' from sakila.language AS ta
join sakila.film AS tb
ON ta.language_id = tb.language_id
group by language_id;

-- 4. Rank categories by the number of films.

SELECT ta.category_id, tb.name, count(ta.film_id) AS 'amount of films', rank() over (order by count(ta.film_id) DESC) as 'Rank' FROM sakila.film_category AS ta
JOIN sakila.category AS tb
ON ta.category_id = tb.category_id
group by category_id;


-- 5.Which actor has appeared in the most films?
/* select * from film_actor;
select * from actor; */

select a.actor_id, a.first_name,a.last_name, count(fa.film_id) AS 'number of films'
from actor a
JOIN
film_actor fa ON a.actor_id = fa.actor_id
group by a.actor_id
order by count(fa.film_id) desc;

-- 6.Most active customer.
/* select * from customer;
select * from rental; */

select c.customer_id , c.first_name , c.last_name , COUNT(r.rental_id) AS number_of_films_rented 
from customer c
join
rental r on c.customer_id = r.customer_id
group by c.customer_id
order by COUNT(r.rental_id) desc;


-- 7.Most rented film.
/* select * from film;
select * from rental;
select * from inventory; */

SELECT f.title,f.film_id,COUNT(r.rental_id) as number_of_rented_films  
from film f 
LEFT JOIN
inventory i ON f.film_id = i.film_id
LEFT JOIN
rental r ON r.inventory_id = i.inventory_id
group by f.film_id
order by COUNT(r.rental_id) desc ;



