#!/bin/bash

curl -L https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v0.2/WideWorldImporters-Full.bak -o WideWorldImporters-Full.bak
docker cp WideWorldImporters-Full.bak mssql_sample:/var/opt/mssql/data
docker exec -ti mssql_sample /opt/mssql-tools/bin/sqlcmd -Usa -PYukon900 -Q 'RESTORE DATABASE WideWorldImporters FROM DISK = "/var/opt/mssql/data/WideWorldImporters-Full.bak" WITH MOVE "WWI_Primary" TO "/var/opt/mssql/data/WideWorldImporters.mdf", MOVE "WWI_Userdata" TO "/var/opt/mssql/data/WideWorldImporters_Userdata.mdf", MOVE "WWI_Log" TO "/var/opt/mssql/data/WideWorldImporters.ldf", MOVE "WWI_InMemory_Data_1" TO "/var/opt/mssql/data/WideWorldImporters_InMemory_Data_1"'
