-- Example "uspGetDirectReports Tests  Testing uspGetDirectReports proc with @businessentityid = 1"
-- ./spec/uspGetDirectReports.rb:5
-- Executed at 2017-08-04 20:12:42 -0700

-- Initiate the example script
begin transaction;

-- Set default options
set textsize 2147483647;
set language us_english;
set dateformat mdy;
set datefirst 7;
set lock_timeout -1;
set quoted_identifier on;
set arithabort on;
set ansi_null_dflt_on on;
set ansi_warnings on;
set ansi_padding on;
set ansi_nulls on;
set concat_null_yields_null on;


-- query 'SET IDENTITY_INSERT Person.BusinessEntity ON;'
SET IDENTITY_INSERT Person.BusinessEntity ON;

-- load_csv 'adventureworks/seed_data/seed_person_businessentity.csv', 'table_name'
INSERT INTO Person.BusinessEntity([BusinessEntityID],[rowguid],[ModifiedDate])
SELECT '1','0c7d8f81-d7b1-4cf0-9c0a-4cd8b6b50087','2017-12-13 13:20:24.150' UNION ALL
SELECT '2','6648747f-7843-4002-b317-65389684c398','2017-12-13 13:20:24.430'

-- Rollback the changes made by the example script
if @@trancount > 0 rollback transaction;

--               SLACKER RESULTS
-- *******************************************
-- Failure/Error: load_csv('adventureworks/seed_data/seed_person_businessentity.csv', 'Person.BusinessEntity')
-- 
-- TinyTds::Error:
--   Violation of PRIMARY KEY constraint 'PK_BusinessEntity_BusinessEntityID'. Cannot insert duplicate key in object 'Person.BusinessEntity'. The duplicate key value is (1).
-- ./lib/helpers/seed_data.rb:10:in `seed_orgchart_data'
-- ./spec/uspGetDirectReports.rb:7:in `block (2 levels) in <top (required)>'
-- *******************************************