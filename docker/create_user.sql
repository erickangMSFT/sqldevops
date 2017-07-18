USE [master]
create login scripter with password = 'Yukon900'
go

USE [AdventureWorks]
GO
create user scripter for login scripter
go

ALTER ROLE [db_datareader] ADD MEMBER [scripter]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [scripter]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [scripter]
GO
GRANT VIEW DEFINITION TO [scripter]
GO