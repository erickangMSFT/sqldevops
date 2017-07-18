#!/bin/bash

#docker pull microsoft/mssql-server-linux:latest
docker images

#create a new container - sqlpass and sqlpassdev
docker run --name sqlpass -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' -p 1433:1433 -d microsoft/mssql-server-linux  

#create backup folder in the container - use -v option to mount an external disk in docker run.
docker exec -it sqlpass mkdir /var/opt/mssql/backup

#cp backup file to the container
docker cp ~/Documents/demos/Adventureworks_Linux.bak sqlpass:/var/opt/mssql/backup

sleep 10

#restore db
sqlcmd -S localhost -U sa -P Yukon900 -i restore_demo.sql 

#mask sensitive user data
sqlcmd -S localhost -d AdventureWorks -U sa -P Yukon900 -i ddm.sql 

#create script user without unmask permission
sqlcmd -S localhost -U sa -P Yukon900 -i create_user.sql 

# script out a subset of database that application needs
mssql-scripter -S localhost -d AdventureWorks -U scripter -P Yukon900 --include-objects HumanResources.uspGetDirectReports HumanResources.uspGetDirectManager --include-dependencies --include-types Schema --exclude-extended-properties --schema-and-data --script-create -f ./script.sql

# spin up sqlpassdev container
docker rm -f sqlpass

docker run --name sqlpassdev -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' -p 1433:1433 -d microsoft/mssql-server-linux  

sleep 10

# create database
sqlcmd -S localhost -U sa -P Yukon900 -i createdb.sql

# execute sql script to create database objects
sqlcmd -S localhost -d AdventureWorks -U sa -P Yukon900 -i script.sql > .executionlog

# commit sqlpassdev to dev-db-container
docker commit sqlpassdev dev-db:latest
docker images

# flattening image to reduce size ***\n"
docker run --name tmp-small -d dev-db-tmp
docker export tmp-small | docker import - dev-db:latest
docker rm -f tmp-small
docker rmi dev-db-tmp

docker images

# build and publish docker images
docker tag dev-db:latest <your azure container registry>dev-db:latest
#docker login sqldevopsacs.azurecr.io
#docker push <your azure container registry>dev-db:latest

docker rmi dev-db
docker rm -f sqlpassdev
docker images

docker run --name troubleshooting -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' -p 1433:1433 -d <your azure container registry>dev-db:latest /opt/mssql/bin/sqlservr

docker rm -f troubleshooting
