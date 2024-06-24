use olympic_history;
-- How many olympics games have been held?
SELECT 
    COUNT(DISTINCT (games))
FROM
    alt_events;
-- List down all Olympics games held so far.
SELECT DISTINCT
    (year), season, city
FROM
    alt_events
ORDER BY year;

-- Fetch the total no of sports played in each olympic games.

select games, count(distinct(sport)) as "no_of_sports" from alt_events
group by games;

-- Find the Ratio of male and female athletes participated in all olympic games.

with male_count as 

	(select count(*) as "m_count" from alt_events
	where sex = "M"),
    
	female_count as
    
	(select count(*) as "f_count" from alt_events
	where sex ="F"),
	ratio as 
(select round((m_count / f_count),2) as "rt" from male_count, female_count)

select concat(1, ":", rt) from ratio;

-- Fetch the top 5 most successful countries in olympics. Success is defined by 
-- no of medals won.
with t1 as 
(SELECT 
    region, COUNT(1) AS 'no_of_medal'
FROM
    alt_events al
        JOIN
    noc_regions nr ON al.noc = nr.Noc
WHERE
    medal IS NOT NULL
GROUP BY nr.Region
ORDER BY no_of_medal DESC),

	t2 as (
    select *, dense_rank() over(order by no_of_medal desc) as "rnk" from t1)
    
select * from t2 where rnk <=5;

-- In which Sport/event, India has won highest medals
SELECT 
    sport, COUNT(*) AS 'no_of_medal'
FROM
    alt_events a
        JOIN
    noc_regions n ON a.NOC = n.Noc
WHERE
    region = 'india' AND medal IS NOT NULL
GROUP BY sport
ORDER BY no_of_medal DESC
LIMIT 1;

-- List down total gold, silver and bronze medals won by each country corresponding to each olympic games.

SELECT 
    COUNT(*) AS 'no_of_medal', medal, region AS 'country'
FROM
    alt_events a
        JOIN
    noc_regions n ON a.NOC = n.Noc
WHERE
    medal IS NOT NULL
GROUP BY region, medal
ORDER BY region, no_of_medal;

create extension tablefunc;


-- Fetch the top 5 athletes who have won the most medals (gold/silver/bronze)
with t1 as (
select Name,team,count(*) as "no_of_medal" from alt_events
where medal is not null
group by Name, team order by no_of_medal desc),
t2 as (select *, dense_rank() over(order by no_of_medal desc) as "rnk" from t1)

select * from t2 
where  rnk <=5;

-- Break down all olympic games where india won medal for Hockey and 
-- how many medals in each olympic games.

SELECT 
    team, sport, games, COUNT(*) AS 'total_medals'
FROM
    alt_events
WHERE
    Medal IS NOT NULL AND team = 'india'
        AND Sport = 'Hockey'
GROUP BY team , sport , games
ORDER BY total_medals DESC;





  
    
    




    
	
    
    
