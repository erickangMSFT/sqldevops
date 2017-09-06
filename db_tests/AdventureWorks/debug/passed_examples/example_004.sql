-- Example "My database can play with numbers"
-- ./spec/sample_1.rb:23
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


-- query '/sample_1/play_with_numbers.sql.erb', options = {:x=>2, :y=>12}
declare @x int;
declare @y int;

set @x = 2;
set @y = 12;

-- Return just the product of @x and @y
select @x * @y [product] union all
select 12;

-- Return the numbers and their sum
select @x x, @y y, @x + @y [sum];

-- Get the two numbers in one column and their sum with 32 in another
select @x p, @x + 32 s union all
select @y p, @y + 32 s;


-- Rollback the changes made by the example script
if @@trancount > 0 rollback transaction;

--               SLACKER RESULTS
-- *******************************************
--              Example Passed OK
-- *******************************************