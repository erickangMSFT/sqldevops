-- Example "My database contains system tables (take three)"
-- ./spec/sample_1.rb:17
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


-- query '/sample_1/sysobjects_with_params.sql.erb', options = {:xtype=>"S"}
select * from sysobjects where xtype = 'S';

-- Rollback the changes made by the example script
if @@trancount > 0 rollback transaction;

--               SLACKER RESULTS
-- *******************************************
--              Example Passed OK
-- *******************************************