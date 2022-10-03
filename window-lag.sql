-- 1. Modify the query to show data from Spain

SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn

-- 2. Modify the query to show confirmed for the day before.

SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn

-- 3. Show the number of new cases for each day, for Italy, for March.

SELECT name,
DAY(whn),
   confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn

-- 6. Include the ranking for the number of deaths in the table.

SELECT 
   name,
   confirmed,
   RANK() OVER (ORDER BY confirmed DESC) rc,
   deaths, 
RANK() OVER (ORDER BY deaths DESC) dc
  FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC, deaths DESC

