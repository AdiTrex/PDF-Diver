-- number of rows in dataset1

SELECT count(*) FROM dataset1

--dataset for jharkhand and bihar

SELECT * FROM dataset1
WHERE state in ('Jharkhand','Bihar')

--total population of india
SELECT SUM(POPULATION) AS Total_population
FROM dataset2

--avg growth of india
SELECT ROUND(AVG(growth),4) AS average_growth 
from dataset1

--avg growth of each state
SELECT State, ROUND(AVG(GROWTH),2) AS avg_growth
FROM dataset1
GROUP BY 1

--avg sex ratio by state
SELECT State, ROUND(AVG(Sex_Ratio),2) AS Sex_ratio_state
FROM dataset1
GROUP BY 1


-- district with highest sex Ratio
SELECT DISTRICT ,state,Sex_ratio
FROM dataset1
ORDER BY 3 DESC 
LIMIT 1

--show top and bottom 3 states in literacy in single table
WITH top_state AS (
       SELECT STATE,ROUND(AVG(literacy),2) AS average_literacy 
       from dataset1
       GROUP BY 1 
	   ORDER BY 2 DESC
	   LIMIT 3
),

 bottom_state AS (
       SELECT STATE,ROUND(AVG(literacy),2) AS average_literacy 
       from dataset1
       GROUP BY 1 
	   ORDER BY 2 ASC
	   LIMIT 3
)
SELECT * FROM top_state
UNION ALL
SELECT * FROM bottom_state 
ORDER BY average_literacy DESC
	
-- states starting with letter A
SELECT STATE FROM dataset1
WHERE State like 'A%'
GROUP BY 1
ORDER BY 1

-- number of males and females
-- Sex ratio = females/males

WITH new_table AS (SELECT d1.district,d1.state,d1.sex_ratio,d2.population 
                   FROM dataset1 d1
                    INNER JOIN dataset2 d2 ON d1.district = d2.district
)

SELECT ROUND(population/(1 + sex_ratio)) AS male_pop, ROUND((sex_ratio*population)/(1+sex_ratio)) AS female_pop
FROM new_table


-- Average literacy statewise

SELECT STATE , ROUND(AVG(literacy),2) AS Avg_literacy
FROM dataset1
GROUP BY state
ORDER BY STATE


-- Query to find population in previous census
--tackled this problem using growth rate of population



SELECT dataset1.district,dataset1.state,dataset2.population AS Current_population , ceil((dataset2.population*100)/(dataset1.growth + 1)) AS previous_pop
FROM dataset1
JOIN dataset2 ON dataset1.district = dataset2.district
ORDER BY 2


-- top 10 population density district
-- population density = population per km2 of area

SELECT district,state,ROUND((population/area_km2),2) AS Population_Density FROM dataset2
ORDER BY 3 DESC
LIMIT 10


-- top 10 population density state

WITH a AS( SELECT district,state,ROUND((population/area_km2),2) AS Population_Density FROM dataset2
            ORDER BY 3 DESC
            )

SELECT a.state , AVG(a.Population_density)
FROM a
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10


--top 3 district from each state which have highest literacy rate

SELECT a.* FROM (SELECT district , state,Literacy,
                 RANK () OVER (PARTITION BY STATE  ORDER BY LITERACY DESC) AS rank 
                 FROM dataset1) AS a

WHERE a.rank < 4











