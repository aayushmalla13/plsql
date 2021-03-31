create or replace view vw_bot20 as 
select ids, cName,totalCases from(
select row_number() over (order by totalCases desc) ids, cName, totalCases
from covidInfo)
where ids <21; 



create or replace view vw_top20 as 
select ids,cName,totalCases from (select row_number() over (order by totalCases asc) ids, cName, totalCases
from covidInfo)
where ids<21;



--
--select * from table(totalFinder);

create or replace view totalNum as
select row_number() over ( order by case_count asc) ids,case_type,case_count from table(totalFinder);

CREATE OR REPLACE VIEW newdata as
select row_number() over (order by cName) ids,cName,newCases,newDeaths from newcovidInfo
where upper(cName)='NEPAL';



-------FINAL QUERY----------
select vw_bot20.cName,vw_bot20.totalCases, vw_top20.cName,vw_top20.totalCases,totalNum.case_type,totalNum.case_count,vw_newdata.cName,vw_newdata.newCases,vw_newdata.newDeaths
from vw_bot20   join vw_top20
on vw_bot20.ids = vw_top20.ids 
 left join totalNum
on
vw_top20.ids= totalNum.ids
left join newdata
on
vw_top20.ids=vw_newdata.ids;



