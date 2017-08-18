-- Example "WideWorldImporters: Website.ChangePassword denies PersonID == 1"
-- ./spec/website/changePassword.rb:12
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


-- query '/WideWorldImporters/website/changePassword.sql.erb', options = {:PersonID=>1, :OldPassword=>"Yukon900", :NewPassword=>"Yukon1000"}
exec Website.ChangePassword 
    @PersonID = '1', 
    @OldPassword = 'Yukon900', 
    @NewPassword = 'Yukon1000'

-- Rollback the changes made by the example script
if @@trancount > 0 rollback transaction;

--               SLACKER RESULTS
-- *******************************************
--              Example Passed OK
-- *******************************************