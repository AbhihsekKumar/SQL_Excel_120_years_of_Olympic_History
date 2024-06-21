use olympic_history;
-- How many olympics games have been held?
select count(distinct(games)) from alt_events;
-- List down all Olympics games held so far.
select distinct(year), season, city from alt_events
order by year;
-- Mention the total no of nations who participated in each 
-- olympics game?
-- Which year saw the highest and lowest no of countries participating in 
-- olympics?
select count(distinct(region)) as "Highest_Country_Participation", year from alt_events a
join noc_regions n on  a.NOC = n.Noc
group by year order by Highest_Country_Participation desc limit 1