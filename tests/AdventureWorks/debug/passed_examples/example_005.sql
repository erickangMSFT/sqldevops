-- Example "My database can play with numbers (take two)"
-- ./spec/sample_1.rb:53
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


-- query '/sample_1/create_my_table.sql.erb'
create table MyTable(x int, y int);

-- load_csv 'sample_1/my_table_initial_data.csv', 'table_name'
INSERT INTO MyTable([x],[y])
SELECT '2','1' UNION ALL
SELECT '3','2' UNION ALL
SELECT '4','3' UNION ALL
SELECT '5','4' UNION ALL
SELECT '4','2' UNION ALL
SELECT '3','3' UNION ALL
SELECT '2','4' UNION ALL
SELECT '1','5' UNION ALL
SELECT '-1','2' UNION ALL
SELECT '-2','5'

-- query '/sample_1/my_table_on_power.sql.erb'
select x, y, convert(int, Power(x, y)) as [power]
  from MyTable;

-- Rollback the changes made by the example script
if @@trancount > 0 rollback transaction;

--               SLACKER RESULTS
-- *******************************************
--              Example Passed OK
-- *******************************************