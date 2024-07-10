select show_id,country 
from netflix_raw nr
inner join 
(select nd.director, nc.country from netflix_country nc
	inner join netflix_directors nd
	on nc.show_id = nd.show_id 
	group by director, country

-----------------------------------------------------------
	select * from netflix_raw where duration is NULL

--------------------------------------------------------------
with CTE as
(
select * ,
ROW_NUMBER() over(partition by title, type order by show_id) as rn
from netflix_raw
)
select show_id, type,title, cast(date_added as date) as date_added, release_year,rating, case when duration is null then rating else duration end as duration, description
into netflix
from CTE


select * from netflix

-- country with the highest number of comedyy movies

select nc.country, count(distinct ng.show_id) as Number_of_Comedies from netflix_country nc 
inner join netflix_genre ng on  nc.show_id = ng.show_id
inner join netflix n on ng.show_id = nc.show_id
where ng.genre = 'comedies' and n.type = 'Movie'
group by nc.country
order by Number_of_Comedies desc



--Director has maximun number of mobies released

select YEAR(date_added) as date_year, nd.director, count(n.show_id) as no_of_movies
from netflix n 
inner join netflix_directors nd on n.show_id = nd.show_id 
group by nd.director,YEAR(date_added)
order by no_of_movies desc

--- What is the average duartion 

select ng.genre, avg(cast(REPLACE (duration,'min', '') AS int)) as avg_duration
from netflix n 
inner join netflix_genre ng on n.show_id = ng.show_id
where type = 'Movie'
group by ng.genre
order by avg_duration desc
-------------------------------------------------
select nd.director,  
count(distinct case when n.type = 'Movie' then n.show_id end) as no_of_movies
,count (distinct case when n.type = 'TV Show' then n.show_id end) as no_of_Tv_shows
from netflix n
inner join netflix_directors nd on n.show_id = nd.show_id 
group by nd.director
having count(distinct n.type) > 1
order by nd.director desc
-----------------------------------------------------------
-- find the list of directors who have created horro and comedy movies
-- display directors name alongn with number of comedies and horror movies\

select nd.director 
--,count(distinct case when ng.genre = 'TV Horror' then n.show_id end) as no_of_Horrors
,count (distinct case when ng.genre = 'Horror Movies' then n.show_id end) as no_of_Horror
,count (distinct case when ng.genre = 'Comedies' then n.show_id end) as no_of_Comedies
 from netflix n
 inner join netflix_genre ng on n.show_id = ng.show_id
 inner join netflix_directors nd on n.show_id = nd.show_id
where type = 'Movie' and genre IN ('Horror Movies','Comedies')
group by nd.director
having count(distinct ng.genre) =2








