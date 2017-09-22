USE [master]
create login scripter with password = 'SqlDevOps2017'
go

USE [WideWorldImporters]
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
print(N'Successfully created user: scripter without UNMASK permission on WideWorldImporters database');