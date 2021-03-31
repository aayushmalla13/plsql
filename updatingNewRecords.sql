-------------PROCEDURE TO UPDATE THE MAIN TABLE WITH NEWRECORDS--------------------
CREATE OR REPLACE PROCEDURE updatecovidInfo(nCases NUMBER,dCases NUMBER,rCases NUMBER ,sCases NUMBER, country VARCHAR)
AS
viewCreation VARCHAR2(255);
BEGIN
execute immediate 'CREATE OR REPLACE VIEW vw_newdata as
select row_number() over (order by cName) ids,cName,newCases,newDeaths from newcovidInfo
where upper(cName)='|| country ||';';
UPDATE covidInfo
SET totalCases= totalCases+ nCases , totalDeaths= totalDeaths+dCases, totalRecovered= totalRecovered+rCases, totalSerious= totalSerious + sCases
WHERE UPPER(cName)= country;

UPDATE newcovidInfo
SET newCases= nCases, newDeaths=dCases
WHERE UPPER(cName)= country;

END updatecovidInfo;
--exec updatecovidInfo(222,222,222,222,'USA');
--

create or replace type obj_record_cases is object (
  case_type varchar2(255),
  case_count number
);
/
create or replace type tbl_record_cases is table of obj_record_cases;
/

CREATE OR REPLACE FUNCTION totalFinder
RETURN tbl_record_cases
IS
NEW_DATA tbl_record_cases := tbl_record_cases();
BEGIN
NEW_DATA.EXTEND(12);
NEW_DATA(1) := obj_record_cases('Total Cases:',totalSerious());

NEW_DATA(2) := obj_record_cases('Total Deaths:',totalDeaths());

NEW_DATA(3) := obj_record_cases('Total Recovered:',totalRecovered());

NEW_DATA(4) := obj_record_cases('Total Active Cases:',totalCases()-totalDeaths()-totalRecovered());

NEW_DATA(5) := obj_record_cases('Total Serious Cases:',totalSerious());

NEW_DATA(6) := obj_record_cases('Serious Cases Percentage:',ROUND((totalSerious()/(totalCases()-totalDeaths()-totalRecovered()))*100,1));

NEW_DATA(7) := obj_record_cases('Serious Cases:',totalCases()-totalDeaths()-totalRecovered()-totalSerious());

NEW_DATA(8) := obj_record_cases('Death Percentage:',ROUND((totalCases()-totalDeaths()-totalRecovered()-totalSerious())/(totalCases()-totalDeaths()-totalRecovered())*100,1));

NEW_DATA(9) := obj_record_cases('Recovered Cases Percentage:',Round(totalRecovered()/(totalDeaths()+totalRecovered())*100) );

NEW_DATA(10) := obj_record_cases('Mild Cases:',totalCases()-totalDeaths()-totalRecovered()-totalSerious() );

NEW_DATA(11) := obj_record_cases('Mild Cases Percentage:',ROUND((totalCases()-totalDeaths()-totalRecovered()-totalSerious())/(totalCases()-totalDeaths()-totalRecovered())*100,1) );

NEW_DATA(12) := obj_record_cases('Position:',rankFinder('NEPAL') );

return NEW_DATA;
END totalFinder;

select * from table(totalFinder);





