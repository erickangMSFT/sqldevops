

rm ./script.sql

write-host "** scripting database ..."
# script out a subset of database that application needs
/usr/local/bin/mssql-scripter -S localhost -d AdventureWorks -U scripter -P Yukon900 --include-objects HumanResources.uspGetDirectReports HumanResources.uspGetDirectManager --include-dependencies --include-types Schema --exclude-extended-properties --schema-and-data --script-create -f ./script.sql

write-host "** find and replace db name ..."
# regex replace if needed 
gci -Path script.sql | ForEach-Object {( Get-Content -Path $_.FullName ) -replace 'AdventureWorks', 'devdb' | set-content $_.fullname }



