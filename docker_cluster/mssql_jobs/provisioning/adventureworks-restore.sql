RESTORE DATABASE [AdventureWorks] 
FROM  DISK = N'/var/opt/mssql/backup/AdventureWorks2014.bak' 
WITH  FILE = 1,  MOVE N'AdventureWorks2014_Data' 
TO N'/var/opt/mssql/data/AdventureWorks_Data.mdf',  
MOVE N'AdventureWorks2014_Log' 
TO N'/var/opt/mssql/data/AdventureWorks_Log.ldf',  NOUNLOAD,  STATS = 5
