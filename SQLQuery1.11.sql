select * from project2.dbo.data1;

select * from project2.dbo.data3;



--number of row in our dataset

select count(*) from project1.data1
select count(*) from project2..data3

-- calculate the dataset jharkhand and bihar

select * from project2..data1 where state in ('jharkhand','bihar');

--population of india
select sum(population) from project2..data3;

select state,avg(Growth)*100 avg from project2..data1 group by state;

-- average sex_ratio
select state,round(avg(Sex_Ratio),0) avg_Sex_Ratio from project2..data1 
group by state  order by avg_Sex_Ratio  desc;

-- average literacy rate
select state,round(avg(Literacy),0) avg_Literacy
from project2..data1 group by state having round(avg(Literacy),0)>85 order by avg_Literacy desc

--top three state showing highest groth rate
select top 3 state,avg(Growth)*100 avg_growth from project2..data1 group by state order by avg_growth
desc
-- or
select state,avg(Growth)*100 avg_growth from project2..data1 group by state order by avg_growth
desc limit 3

--inorder to print the buttom lowerst sex rate
select top 3 state,round(avg(Sex_Ratio),0)avg_Sex_Ratio  from project2..data1 
group by state  order by avg_Sex_Ratio  asc;

-- top 3 statea and bottom 3 state im literacy
drop table if exists #topstates;
create table #topstates
( state varchar(200),
topstair float
)
insert into #topstates 
select  state,round(avg(Literacy),0) avg_Literacy_rate  from project2..data1 
group by state  order by avg_Literacy_rate  desc;

create table #bottomstates
( state varchar(200),
bottomstair float
)
insert into #bottomstates 
select  state,round(avg(Literacy),0) avg_Literacy_rate  from project2..data1 
group by state  order by avg_Literacy_rate  desc;


select top 3 * from #bottomstates order by #bottomstates.bottomstair desc;
--union operator
select * from(
select top 3 * from #topstates order by #topstates.topstair desc) a

union

select * from(
select top 3 * from #bottomstates order by #bottomstates.bottomstair asc) b

-- state staring letter with a
select * from project2..data1 where lower(state) like 'a%'

select state from project2..data1 where lower(state) like 'a%'

select * from project2..data1 where state like 'a%'

select state from project2..data1 where state like 'a%'or state like 'b%'

select state from project2..data1 where lower(state) like 'a%'and lower(state) like '%h'
select state from project2..data1 where state like 'p%'

--joining both the table

select a.district ,a.state,a.sex_ratio,b.population from project2..data1 a
inner join project2..data3 b on a.district=b.district
--literacy rate
select c.state,sum(literacy_people),sum(illeracy_people) from
(select d.district,d.state,round(d.literacy_ratio*d.population,0) literate_people,
(1-d.literacy_ratio)*d.population illeracy_people from
(select a.district,a.state,a.literacy literacy_ratio,b.population from project2..data1 a 
inner join project2..data3 b on a.district=b.district) d) group by c.state







