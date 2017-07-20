#!/bin/bash

# docker pull microsoft/mssql-server-linux:latest
docker images

# create a new container with a data volume
clear
docker run --name sqldevops -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' -p 1433:1433 -v /Users/erickang/dockershare:/backups  -d microsoft/mssql-server-linux  
docker ps
docker exec -it sqldevops ls /backups

# prepare database to script out restore db | mask sensitive user data | create user without UNMASK permission
clear
sqlcmd -S localhost -U sa -P Yukon900 -i restore_demo.sql 
sqlcmd -S localhost -Usa -P Yukon900 -Q'select name from sys.databases'

clear
sqlcmd -S localhost -dAdventureWorks -U sa -P Yukon900 -i ddm.sql 
sqlcmd -S localhost -U sa -P Yukon900 -i create_user.sql
sqlcmd -dAdventureWorks -Uscripter -PYukon900 -Q'select top(10) BusinessEntityID, EmailAddress, PhoneNumber from HumanResources.vEmployee'

# script out a subset of database that application needs
clear
mssql-scripter -S localhost -d AdventureWorks -U scripter -P Yukon900 --include-objects HumanResources.uspGetDirectReports HumanResources.uspGetDirectManager --include-dependencies --include-types Schema --exclude-extended-properties --schema-and-data --script-create -f ./script.sql

# spin up sqlpassdev container
docker rm -f sqldevops
docker run --name sqldev -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' -p 1433:1433 -d microsoft/mssql-server-linux  
docker ps

# create database, schema and insert statically masked data
sqlcmd -S localhost -U sa -P Yukon900 -i createdb.sql
sqlcmd -S localhost -dAdventureWorks -U sa -P Yukon900 -i script.sql > .executionlog
sqlcmd -dAdventureWorks -Usa -PYukon900 -Q'select top(10) BusinessEntityID, EmailAddress, PhoneNumber from HumanResources.vEmployee'

# commit sqlpassdev to dev-db-container
docker commit sqldev dev-db:latest
docker images

# flattening image to reduce size ***\n"
docker run --name tmp-small -d dev-db-tmp
docker export tmp-small | docker import - dev-db:latest
docker rm -f tmp-small
docker rmi dev-db-tmp

docker images

# build and publish docker images
docker tag dev-db:latest sqldevopsacs.azurecr.io/dev-db:latest
#docker login sqldevopsacs.azurecr.io
docker push sqldevopsacs.azurecr.io/dev-db:latest

# check azure container registry
clear
az acr repository list -n sqldevopsACS
az acr repository show-tags -n sqldevopsACS --repository dev-db
#az acr repository show-manifests -n sqldevopsACS --repository dev-db

#clean-up
clear
docker rmi dev-db
docker rm -f sqldev
docker rmi sqldevopsacs.azurecr.io/dev-db
docker images
docker ps


# As a developer, user can simply run docker run command to start working with the new image
docker run --name troubleshooting -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' -p 1433:1433 -d sqldevopsacs.azurecr.io/dev-db:latest /opt/mssql/bin/sqlservr

sqlcmd -dAdventureWorks -Usa -PYukon900 -Q'select top(10) BusinessEntityID, EmailAddress, PhoneNumber from HumanResources.vEmployee'

# clean up
clear
docker rm -f troubleshooting
docker rmi sqldevopsacs.azurecr.io/dev-db
docker ps
docker images