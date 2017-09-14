DECLARE @name VARCHAR(50)
-- database name  
DECLARE @path VARCHAR(256)
-- path for backup files  
DECLARE @fileName VARCHAR(256)
-- filename for backup  
DECLARE @fileDate VARCHAR(20)
-- used for file name
DECLARE @rowsToProcess int
DECLARE @currentRow int
-- specify database backup directory
SET @path = '/var/opt/mssql/backup/'
-- specify filename format
SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112)
DECLARE @db_table TABLE (rowid int not null primary key identity(1,1),
    name varchar(50) )
INSERT into @db_table
    (name)
SELECT name
FROM master.dbo.sysdatabases
WHERE name NOT IN ('master','model','msdb','tempdb');

SET @rowsToProcess=@@ROWCOUNT;
SET @currentRow=0;
WHILE @currentRow<@rowsToProcess
BEGIN
    SET @currentRow=@currentRow+1;
    SELECT @name=name
    FROM @db_table
    WHERE rowid=@currentRow;
    SET @fileName = @path + @name + '_' + @fileDate + '.BAK';
    print N'---------------------------------------------------------------';
    print N'Backup [' + @name + '] to ' + @fileName;
    BACKUP DATABASE @name TO DISK = @fileName;
END