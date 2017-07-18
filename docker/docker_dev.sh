#!/bin/bash

docker rm -f sqlpass

docker run --name sqlpassdev -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' -p 1433:1433 -d microsoft/mssql-server-linux  

sleep 10

# create database
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Yukon900 -i createdb.sql

# execute sql script to create database objects
/opt/mssql-tools/bin/sqlcmd -S localhost -d AdventureWorks -U sa -P Yukon900 -i script.sql > .executionlog

# commit sqlpassdev to dev-db-container
docker commit sqlpassdev dev-db:latest

#docker tag dev-db:latest sqldevopsacs.azurecr.io/sqldevops/dev-db:latest

docker rm -f sqlpassdev