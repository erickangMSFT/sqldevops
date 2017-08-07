RESTORE DATABASE [WideWorldImporters] FROM DISK = N'/var/opt/mssql/backup/WorldWideImporters2017.bak' with recovery, replace
print(N'Successfully restored WideWorldImporters');
