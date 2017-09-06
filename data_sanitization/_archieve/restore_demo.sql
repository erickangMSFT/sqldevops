RESTORE DATABASE [AdventureWorks] FROM DISK = N'/backups/AdventureWorks_Linux.bak' with recovery, replace
print(N'Successfully restored AdventureWorks');
