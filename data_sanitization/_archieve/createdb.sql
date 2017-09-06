-- Create a new database called 'AdventureWorks'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use.
--ALTER DATABASE AdventureWorks SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--GO
-- Drop the database if it exists
IF EXISTS (
  SELECT name
   FROM sys.databases
   WHERE name = N'AdventureWorks'
)
DROP DATABASE AdventureWorks
GO

CREATE DATABASE AdventureWorks
GO
