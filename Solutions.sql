
CREATE DATABASE Netflix;
USE Netflix;

CREATE TABLE netflix (
    show_id VARCHAR(10),
    type VARCHAR(20),
    title VARCHAR(250),
    director VARCHAR(250),
    cast VARCHAR(1000),
    country VARCHAR(150),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(20),
    listed_in VARCHAR(100),
    description VARCHAR(500)
);

USE Netflix;
select count(*) from netflix as total;


-- 1. Count the number of Movies vs TV Shows
select type, count(*)
from Netflix
group by type;

-- 2. Find the most common rating for movies and TV shows

select rating, count(*) as common_rating
from Netflix
group by rating
order by common_rating desc
limit 1;

-- 3. List all movies released in a specific year (e.g., 2020)

select title
from Netflix
where type = 'Movie' and release_year = 2020;


-- 4. Find the top 5 countries with the most content on Netflix

select country, count(*) as top_5_countries
from netflix
where country is not null
group by country
order by top_5_countries desc
limit 5;

-- 5. Identify the longest movie

select title, duration as longest_movie
from netflix 
where type = 'Movie'
order by cast(substring_index(duration, ' ', 1) as unsigned) desc
limit 1;

-- 6. Find content added in the last 5 years
SELECT title, date_added, type
FROM netflix
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC;


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select title, type
from netflix
where director = 'Rajiv Chilaka';


-- 8. List all TV shows with more than 5 seasons
select title
from netflix
where type = 'TV Show' and cast(substring_index(duration, ' ', 1) as unsigned) > 5;

-- 9. Count the number of content items in each genre
SELECT listed_in as Genre, COUNT(*) as Total_Content
FROM netflix
WHERE listed_in IS NOT NULL
GROUP BY listed_in
ORDER BY Total_Content DESC;


-- 10.Find each year and the average numbers of content release in India on netflix. 
-- return top 5 year with highest avg content release!
SELECT 
    release_year, 
    COUNT(show_id) as content_count,
    ROUND(COUNT(show_id) / 12, 1) as avg_monthly_release
FROM netflix
WHERE country LIKE '%India%' -- Catches "India", "India, USA", etc.
GROUP BY release_year
ORDER BY content_count DESC
LIMIT 5;


-- 11. List all movies that are documentaries
select title
from netflix
where type = 'Movie' and listed_in like '%Documentaries%';


-- 12. Find all content without a director
select title
from netflix
where director is Null;


-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select count(*)
from netflix
where cast like '%Salman Khan%' and type = 'Movie' and STR_TO_DATE(date_added, '%M %d, %Y') >= DATE_SUB(CURDATE(), INTERVAL 10 YEAR);



-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
WITH RECURSIVE actor_split AS (

  SELECT 
    TRIM(SUBSTRING_INDEX(cast, ',', 1)) AS actor_name,
    TRIM(SUBSTRING(cast, LENGTH(SUBSTRING_INDEX(cast, ',', 1)) + 2)) AS remainder
  FROM netflix
  WHERE country LIKE '%India%' AND type = 'Movie' AND cast IS NOT NULL

  UNION ALL


  SELECT 
    TRIM(SUBSTRING_INDEX(remainder, ',', 1)),
    TRIM(SUBSTRING(remainder, LENGTH(SUBSTRING_INDEX(remainder, ',', 1)) + 2))
  FROM actor_split
  WHERE remainder <> ''
)

SELECT actor_name, COUNT(*) as movie_count
FROM actor_split
WHERE actor_name != ''
GROUP BY actor_name
ORDER BY movie_count DESC
LIMIT 10;



-- 15.
-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.

SELECT 
    CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) as content_count
FROM netflix
GROUP BY category;











