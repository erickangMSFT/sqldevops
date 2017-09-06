-- Drop the database 'WideWorldImportersTest'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use.
 ALTER DATABASE WideWorldImportersTest SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Drop the database if it exists
IF EXISTS (
  SELECT name
   FROM sys.databases
   WHERE name = N'WideWorldImportersTest'
)
DROP DATABASE WideWorldImportersTest
GO