------- Functions to find rank of the Country -------
CREATE OR REPLACE FUNCTION rankFinder(countryName VARCHAR2)
RETURN VARCHAR2
IS
pos NUMBER(5);
BEGIN
SELECT cpos INTO pos FROM (
SELECT ci.*, DENSE_RANK() OVER(ORDER BY totalCases DESC) cpos
from covidInfo ci
)
where UPPER(cName)= countryName;
RETURN pos;
END rankFinder;
/

SELECT rankFinder('USA') AS POSITION FROM DUAL;

------- FUNCTION TO FIND TOTALCASES -------------
CREATE OR REPLACE FUNCTION totalCases
RETURN NUMBER
AS
totalCases NUMBER(20);
results   varchar2(255);
BEGIN
SELECT SUM(ci.totalCases) into totalCases
FROM covidInfo ci;
results:= totalCases;
RETURN results ;
END totalCases;

------- FUNCTION TO FIND TOTAL DEATHS-------------
CREATE OR REPLACE FUNCTION totalDeaths
RETURN NUMBER
AS
totalDeaths NUMBER(20);
results   varchar2(255);
BEGIN
-----------------------------
SELECT SUM(ci.totalDeaths) into totalDeaths
FROM covidInfo ci;
-----------------------------
results:= totalDeaths;
RETURN results ;
END totalDeaths;



-----FUNCTION TO FIND TOTAL RECOVERED CASES -------------
CREATE OR REPLACE FUNCTION totalRecovered
RETURN NUMBER
AS
totalRecovered NUMBER(20);
results   varchar2(255);
BEGIN
SELECT SUM(ci.totalRecovered) into totalRecovered
FROM covidInfo ci;
-----------------------------
results:= totalRecovered;
RETURN results ;
END totalRecovered;

-----FUNCTION TO FIND TOTAL SERIOUS CASES-------------
CREATE OR REPLACE FUNCTION totalSerious
RETURN NUMBER
AS
totalSerious  NUMBER(20);
results   varchar2(255);
BEGIN
SELECT SUM(ci.totalSerious) into totalSerious
FROM covidInfo ci;
results:= totalSerious;
RETURN results ;
END totalSerious;

SELECT totalCases as "Total Cases" ,
totalDeaths as "Total Deaths"  ,
totalRecovered "Total Recovered Cases",
totalCases-totalDeaths-totalRecovered as ACTIVE_CASES,
totalSerious as "Total Serious",
ROUND((totalSerious/(totalCases-totalDeaths-totalRecovered))*100,1) AS SERIOUS_PERCENTAGE,
totalCases-totalDeaths-totalRecovered-totalSerious AS MILD_CASES,
ROUND((totalCases-totalDeaths-totalRecovered-totalSerious)/(totalCases-totalDeaths-totalRecovered)*100,1) AS MILD_CASES_PERCENTAGE,
totalDeaths+totalRecovered as Closed_Cases,
Round(totalDeaths/(totalDeaths+totalRecovered)*100) as DEATHS_PERCENTAGE,
Round(totalRecovered/(totalDeaths+totalRecovered)*100) as RECOVERED_PERCENTAGE,
rankFinder('NEPAL') "POSITION OF NEPAL" from dual;



---------------------------------------------------------------------

