select *
from pjmaster

-- Total Awards by unit in three years 2020, 2021, 2022
select year, 
	   unit,
       sum(award) Total_award
from pjmaster
group by year, unit
order by 1,3 desc

-- Total Awards by unit 
select unit, 
       sum(award) Total_award
from pjmaster
group by unit
order by 2 desc

-- Total Awards by year
select year Year,
       sum(award) Total_award
from pjmaster
group by year
order by 2 desc


--select award22.unit, award2022, award2021, award2020
--from
--(select unit, sum(award) award2022
--from pjmaster
--where year = 2022
--group by unit) as award22
--inner join 
--(select unit, sum(award) award2021
--from pjmaster
--where year = 2021
--group by unit) as award21
--on award22.unit = award21.unit
--inner join
--(select unit, sum(award) award2020
--from pjmaster
--where year = 2020
--group by unit) as award20
--on award22.unit = award20.unit

-- Looking at the change rate of total award per unit in two period 2022-2021 and 2021-2020

WITH ctepivot AS (
select award22.unit, award2022, award2021, award2020
from
(select unit, sum(award) award2022
from pjmaster
where year = 2022
group by unit) as award22
inner join 
(select unit, sum(award) award2021
from pjmaster
where year = 2021
group by unit) as award21
on award22.unit = award21.unit
inner join
(select unit, sum(award) award2020
from pjmaster
where year = 2020
group by unit) as award20
on award22.unit = award20.unit
)
select unit,
       CASE
	      WHEN award2021 <>0 
		  THEN (award2022-award2021)/award2021 *100
		  ELSE NULL
	   END changerate2122,
	   CASE
	      WHEN award2020 <>0
		  THEN (award2021-award2020)/award2020 *100 
		  ELSE NULL
	   END changerate2120
from ctepivot
order by 2,3 desc

-- Looking at the cost_center breakdown of each unit
select year,  unit, cost_center, sum(award) Total_award
from pjmaster
group by year, unit, cost_center


select year,  unit, cost_center, sum(award) Total_award
from pjmaster
group by year, unit, cost_center
order by 1, 2, 4 desc


-- Looking at the cost center for each unit getting more award and less award
WITH cteawardcc AS (
select year,  unit, cost_center, sum(award) Total_award
from pjmaster
group by year, unit, cost_center
)
select *
from cteawardcc awardccin
where Total_award = (select Max(Total_award) from cteawardcc awardccout where awardccin.unit = awardccout.unit and awardccin.year = awardccout.year)
order by year desc, Total_award desc

WITH cteawardcc AS (
select year,  unit, cost_center, sum(award) Total_award
from pjmaster
group by year, unit, cost_center
)
select *
from cteawardcc awardccin
where Total_award = (select Min(Total_award) from cteawardcc awardccout where awardccin.unit = awardccout.unit and awardccin.year = awardccout.year)
order by year desc, Total_award desc


-- Looking at PI
select year, pi, unit, count(pi) NumberAwards, sum(award) TotalAwards
from pjmaster
group by year , pi, unit 
order by 1 desc, 3 desc

select pi,unit, count(pi) NumberAwards, sum(award) TotalAwards
from pjmaster
--where pi = 'Roni Dahir'
group by pi, unit
order by 3 desc, 1

select pi, count(pi), sum(award)
from pjmaster
group by pi
order by 2 desc


-- Looking at star PI in each unit
select TOP 5 year, pi, unit, sum(award) as TotalAward
from pjmaster
where year = 2022
group by year, pi, unit
order by 4 desc

select TOP 5 year, pi, unit, sum(award) as TotalAward
from pjmaster
where year = 2021
group by year, pi, unit
order by 4 desc

select TOP 5 year, pi, unit, sum(award) as TotalAward
from pjmaster
where year = 2020
group by year, pi, unit
order by 4 desc

-- Looking at sponsor
select *
from pjmaster

select year, sponsor, count(sponsor) NumberSponsor, sum(award) TotalAward
from pjmaster
group by year, sponsor
order by 1 desc, 3 desc,4 desc

select year, count(sponsor) NumberSponsor
from pjmaster
group by year

select unit, count(unit) NumberSponsor
from pjmaster
where sponsor = 'National Science Foundation'
group by unit
order by 2 desc

select sponsor, count(sponsor) NumberSponsor
from pjmaster
where unit ='School of Medicine'
group by sponsor
order by 2 desc


