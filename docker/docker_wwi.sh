#!/bin/bash

docker run --name mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' -p 1433:1433 -d microsoft/mssql-server-linux  
docker exec -ti mssql mkdir /var/opt/mssql/backup
cp ~/dockershare/WorldWideImporters2017.bak mssql:/var/opt/mssql/backup
sqlcmd -Usa -PYukon900 -i restore_wwi.sql 
sqlcmd -Usa -P Yukon900 -Q'select name from sys.databases'


docker commit mssql mssql:20170806-2
docker images


docker build ./docker_build -t mssql:20170806-2
docker tag mssql:20170806-2 sqldevopsacs.azurecr.io/mssql:20170806-2


#docker login sqldevopsacs.azurecr.io
docker push sqldevopsacs.azurecr.io/mssql:20170806-2
docker tag sqldevopsacs.azurecr.io/mssql:20170806-2 sqldevopsacs.azurecr.io/mssql:latest
docker push sqldevopsacs.azurecr.io/mssql:latest
az acr repository list -n sqldevopsACS
az acr repository show-tags -n sqldevopsACS --repository mssql


docker run --name sqldev -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' -p 1433:1433 -d sqldevopsacs.azurecr.io/mssql:20170806-2 /opt/mssql/bin/sqlservr
