#!/usr/local/bin/powershell
write-host "** cleanup intermediate files" -foreground green
rm -f ./out/*.*

write-host "** drop WideWorldImportersTest database" -foreground green
sqlcmd -Usa -PYukon900 -i ./sql/drop_testdb.sql

write-host "** generae script wiht mssql-scripter schema only" -foreground green
mssql-scripter -Slocalhost -dWideWorldImporters -Usa -PYukon900 > ./out/wwi.sql

write-host "** find and replace db name from WideWorldImporters to WideWorldImportersTest" -foreground green
Get-ChildItem -Path ./out/wwi.sql | ForEach-Object {( Get-Content -Path $_.FullName ) -replace 'WideWorldImporters', 'WideWorldImportersTest' | set-content $_.fullname }

write-host "** create WideWorldImportersTest database" -foreground green
sqlcmd  -Usa -PYukon900 -i ./out/wwi.sql

write-host "** bcp out reference tables from WideWorldImporters" -foreground green
/usr/local/bin/powershell ./bash/bcp_out_loop.ps1

write-host "** bcp in reference tables to WideWorldImportersTest" -foreground green
/usr/local/bin/powershell ./bash/bcp_in_loop.ps1


write-host "** cleanup intermediate files" -foreground green
rm -f ./out/*.*

write-host "** end of init_db" -foreground green


