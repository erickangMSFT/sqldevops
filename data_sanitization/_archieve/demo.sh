#!/bin/bash

# Mount Azure file
# sudo apt-get install cifs-utils
# mkdir /azurebackups
# sudo mount -t cifs //<yourstorage>.file.core.windows.net/backups /azurebackups -o vers=3.0,username=<username>,password=<password>,dir_mode=0777,file_mode=0777
 
docker pull microsoft/mssql-server-linux:latest


docker images

# Option 1. create a new container with a data volume
clear
docker run --name sqldevops -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=SqlDevOps2017' -p 1433:1433 -v /Users/erickang/dockershare:/backups  -d microsoft/mssql-server-linux  
docker ps
docker exec -it sqldevops ls /backups

# Option 2. mount data volumee and backup volume for user databases
# docker volume create sqldb
# docker run --name sqlserver -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=SqlDevOps2017' -p 1433:1433 -v /sqldb -v /Users/erickang/dockershare:/backups  -d microsoft/mssql-server-linux  
# docker exec sqlserver /opt/mssql/bin/mssql-conf set filelocation.defaultdatadir /sqldb
# docker exec sqlserver /opt/mssql/bin/mssql-conf set filelocation.defaultlogdir /sqldb
# docker restart sqlserver
# sqlcmd -Usa -PSqlDevOps2017 -i ./get_default_path.sql

# Option 3. mount data volume with system and user databases and mount /backups from host directory mount 
# docker run --name mssql -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=SqlDevOps2017' --cap-add SYS_PTRACE -p 1433:1433 -v sqlvolume:/var/opt/mssql -v /Users/erickang/dockershare:/backups -d microsoft/mssql-server-linux


# prepare database to script out restore db | mask sensitive user data | create user without UNMASK permission
clear
sqlcmd -S 127.0.0.1 -U sa -P SqlDevOps2017 -i restore_demo.sql 
sqlcmd -S 127.0.0.1 -Usa -P SqlDevOps2017 -Q'select name from sys.databases'

clear
sqlcmd -S 127.0.0.1 -dAdventureWorks -U sa -P SqlDevOps2017 -i ddm.sql 
sqlcmd -S 127.0.0.1 -U sa -P SqlDevOps2017 -i create_user.sql

sqlcmd -S 127.0.0.1 -dAdventureWorks -Uscripter -PSqlDevOps2017 -Q'select top(10) BusinessEntityID, EmailAddress, PhoneNumber from HumanResources.vEmployee'

# script out a subset of database that application needs
clear
mssql-scripter -S localhost -d AdventureWorks -U scripter -P SqlDevOps2017 --include-objects HumanResources.uspGetDirectReports HumanResources.uspGetDirectManager --include-dependencies --include-types Schema --exclude-extended-properties --schema-and-data --script-create -f ./script.sql

# spin up sqlpassdev container
docker rm -f sqldevops
docker run --name sqldev -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=SqlDevOps2017' -p 1433:1433 -d microsoft/mssql-server-linux  
docker ps

# create database, schema and insert statically masked data
sqlcmd -S 127.0.0.1 -U sa -P SqlDevOps2017 -i createdb.sql
sqlcmd -S 127.0.0.1 -dAdventureWorks -U sa -P SqlDevOps2017 -i script.sql > .executionlog
sqlcmd -S 127.0.0.1 dAdventureWorks -Usa -PSqlDevOps2017 -Q'select top(10) BusinessEntityID, EmailAddress, PhoneNumber from HumanResources.vEmployee'

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
docker build ./docker_build -t dev-db:latest
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
docker run --name troubleshooting -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=SqlDevOps2017' -p 1433:1433 -d sqldevopsacs.azurecr.io/dev-db:latest /opt/mssql/bin/sqlservr

sqlcmd -dAdventureWorks -Usa -PSqlDevOps2017 -Q'select top(10) BusinessEntityID, EmailAddress, PhoneNumber from HumanResources.vEmployee'

# clean up
clear
docker rm -f troubleshooting
docker rmi sqldevopsacs.azurecr.io/dev-db
docker ps
docker images