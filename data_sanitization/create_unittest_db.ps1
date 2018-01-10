#!/usr/bin/pwsh

# Install SQL Server CLI tools.

# apt-get mssql-tools unixodbc-dev
# apt-get python python-pip
# pip install mssql-scripter

$hostname="localhost"

write-host "Restoring pre-production backup" -foreground green
/opt/mssql-tools/bin/sqlcmd -S $hostname -Usa -P SqlDevOps2017 -i ./sql/restore.sql 

# check the server name: in this demo $hostname is the name of docker host machine. replace $hostname to your docker host name.
# check the server name in bash folder and replace the name of docker host name.

write-host "Enable Dynamic Data masking on WideWorldImporters"
/opt/mssql-tools/bin/sqlcmd -S $hostname -dWideWorldImporters -U sa -P SqlDevOps2017 -i ./sql/ddm.sql 
/opt/mssql-tools/bin/sqlcmd -S $hostname -U sa -P SqlDevOps2017 -i ./sql/create_user.sql

write-host "** cleanup intermediate files" -foreground green
#mkdir ./out
rm -f ./out/*.*

#write-host "** drop WideWorldImportersTest database" -foreground green
#/opt/mssql-tools/bin/sqlcmd -S $hostname -Usa -PSqlDevOps2017 -i ./sql/drop_testdb.sql

write-host "** generae script with mssql-scripter schema only" -foreground green
/usr/local/bin/mssql-scripter -S $hostname -dWideWorldImporters -Usa -PSqlDevOps2017 -f ./out/wwi.sql

#write-host "** find and replace db name from WideWorldImporters to WideWorldImportersTest" -foreground green
#Get-ChildItem -Path ./out/wwi.sql | ForEach-Object {( Get-Content -Path $_.FullName ) -replace 'WideWorldImporters', 'WideWorldImportersTest' | set-content $_.fullname }
write-host "** reduce the database file size" -foreground green
Get-ChildItem -Path ./out/wwi.sql | ForEach-Object {( Get-Content -Path $_.FullName ) -replace 'SIZE = .*KB ,', '' | set-content $_.fullname }

write-host "** bcp out reference tables from WideWorldImporters" -foreground green
pwsh ./bash/bcp_out_loop.ps1

write-host "** drop pre-production backup" -foreground green
/opt/mssql-tools/bin/sqlcmd -S $hostname -Usa -P SqlDevOps2017 -i ./sql/drop_preprod.sql

write-host "** create WideWorldImportersTest database" -foreground green
/opt/mssql-tools/bin/sqlcmd -S $hostname -Usa -PSqlDevOps2017 -i ./out/wwi.sql

write-host "** bcp in reference tables to WideWorldImportersTest" -foreground green
pwsh ./bash/bcp_in_loop.ps1

write-host "** cleanup intermediate files" -foreground green
rm -f ./out/*.*

write-host "** end of init_db" -foreground green


