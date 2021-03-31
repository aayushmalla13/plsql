set serveroutput on;
CREATE OR REPLACE PACKAGE covidManagement AS
totalCases covidInfo.totalCases%TYPE;
totalDeaths covidInfo.totalDeaths%TYPE;
totalRecovered covidInfo.totalRecovered%TYPE;
totalSerious covidInfo.totalSerious%TYPE;
--
--FUNCTION rankFinder(countryName VARCHAR2)
--RETURN VARCHAR2;

PROCEDURE totalInfo(totalc OUT NUMBER);

END covidManagement;
/

CREATE OR REPLACE PACKAGE BODY covidManagement AS

PROCEDURE totalInfo(totalc OUT NUMBER)
AS
BEGIN
SELECT SUM(ci.totalCases) into totalc
FROM covidInfo ci;
dbms_output.put_line(totalc);
END totalInfo;

END covidManagement;
/

EXEC covidManagement.totalInfo(covidManagement.totalCases);
dbms_output.put_line(covidManagement.totalCases);
