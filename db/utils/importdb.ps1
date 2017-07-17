

mssql-scripter -S localhost -d AdventureWorks --file-per-object --script-create --exclude-use-database --display-progress -f .\src

gci -Path ./src/*.sql | ForEach-Object { ( Get-Content -Path $_.FullName ) -replace 'SET.*(ON|OFF)$', '' | set-content $_.fullname }

rm ./src/*.Database.sql

move ./src/*.Table.sql ./src/tables
move ./src/*.View.sql ./src/views
move ./src/*.Type.sql ./src/types
move ./src/*Function.sql ./src/functions
move ./src/*Procedure.sql ./src/procedures
move ./src/*User.sql ./src/security
move ./src/*Schema.sql ./src/security
move ./src/*.sql ./src/misc
