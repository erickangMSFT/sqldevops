-- Example "WideWorldImporters: Website.ChangePassword successfully changes a password"
-- ./spec/website/changePassword.rb:2
-- Executed at 2017-08-16 17:41:54 -0700

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


-- query '/WideWorldImporters/website/init_n_changePassword.sql.erb', options = {:PersonID=>3150, :LogonName=>"emily@widworldimporters.com", :InitialPassword=>"Yukon900", :NewPassword=>"Yukon1000"}
exec Website.ActivateWebsiteLogon 
    @PersonID = '3150', 
    @LogonName = 'emily@widworldimporters.com', 
    @InitialPassword = 'Yukon900'

exec Website.ChangePassword 
    @PersonID = '3150', 
    @OldPassword = 'Yukon900', 
    @NewPassword = 'Yukon1000'

-- Rollback the changes made by the example script
if @@trancount > 0 rollback transaction;

--               SLACKER RESULTS
-- *******************************************
-- Failure/Error:
--   expect{
--       sql.WideWorldImporters.website.init_n_changePassword(
--           :PersonID => 3150, 
--           :LogonName => 'emily@widworldimporters.com', 
--           :InitialPassword => 'Yukon900', 
--           :NewPassword => 'Yukon1000')}
--       .not_to raise_error
-- 
--   expected no Exception, got #<TinyTds::Error: Could not find stored procedure 'Website.ActivateWebsiteLogon'.> with backtrace:
--     # ./spec/website/changePassword.rb:4:in `block (3 levels) in <top (required)>'
--     # ./spec/website/changePassword.rb:3:in `block (2 levels) in <top (required)>'
-- ./spec/website/changePassword.rb:3:in `block (2 levels) in <top (required)>'
-- *******************************************