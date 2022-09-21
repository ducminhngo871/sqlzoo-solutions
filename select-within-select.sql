-- 1. List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

per capita GDP: The per capita GDP is the gdp/population

SELECT name
FROM world
WHERE 
continent = 'Europe'
AND 
gdp/population > 
(
SELECT gdp/population
FROM world
WHERE name = 'United Kingdom'
)

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT name, continent
FROM world
WHERE continent IN 
(
SELECT continent
FROM world
WHERE name IN ('Argentina', 'Australia')
)
ORDER BY name

-- 4. Which country has a population that is more than United Kingom but less than Germany? Show the name and the population.

SELECT name, population
FROM world
WHERE population > 
(SELECT population 
FROM world
WHERE name = 'United Kingdom')
AND population < 
(SELECT population 
FROM world
WHERE name = 'Germany')

-- 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

The format should be Name, Percentage for example:

SELECT name, CONCAT(CAST(100*ROUND((population / (SELECT population FROM world WHERE name ='Germany')), 2) AS INT), '%')
FROM world
WHERE continent = 'Europe';

-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

The first way I am doing will be to find the highest gdp in Europe, then compare that to find these countries. 

SELECT name
FROM world
WHERE gdp > (
SELECT max(gdp)
FROM world
WHERE continent = 'Europe')

Another method you can use will revolve with ALL SQL Function: 

SELECT name FROM world 
WHERE gdp > ALL(
SELECT gdp FROM world 
WHERE continent = 'Europe' AND
gdp IS NOT NULL
)

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area:

SELECT x.continent, x.name, x.area
FROM world AS x
WHERE x.area = (
  SELECT MAX(y.area)
  FROM world AS y
  WHERE x.continent = y.continent)
  
 -- 8. List each continent and the name of the country that comes first alphabetically.

Select  x.continent, x.name
From world x
Where x.name <= ALL (select y.name from world y where x.continent=y.continent)
ORDER BY name

-- 9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

SELECT a.name, a.continent, a.population FROM world AS a
WHERE 25000000 >= ALL(
SELECT b.population FROM world AS b
WHERE b.continent = a.continent)

-- 10. Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.

BE CAREFUL! Remember to filter out the countries' name in the WHERE statement!

SELECT a.name, a.continent
FROM world AS a
WHERE a.population / 3 > ALL (
SELECT b.population  FROM world AS b
WHERE a.continent = b.continent
AND a.name <> b.name)



