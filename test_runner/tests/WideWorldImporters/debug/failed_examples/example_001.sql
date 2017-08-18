-- Example "WideWorldImporters: Website.SearchForSuppliers successfully find suppliers"
-- ./spec/website/searchForSuppliers.rb:3
-- Executed at 2017-08-18 12:35:44 -0700

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


-- Rollback the changes made by the example script
if @@trancount > 0 rollback transaction;

--               SLACKER RESULTS
-- *******************************************
-- Failure/Error: raise ("unittest failure demonstration")
-- 
-- RuntimeError:
--   unittest failure demonstration
-- ./spec/website/searchForSuppliers.rb:4:in `block (2 levels) in <top (required)>'
-- *******************************************