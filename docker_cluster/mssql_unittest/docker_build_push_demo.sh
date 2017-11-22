#!/bin/bash

docker pull microsoft/mssql-server-linux:latest

docker run --name unittestdb -e "ACCEPT_EULA=Y" -p 1433:1433 -d microsoft/mssql-server-linuxt:latest

pwsh ./sanitize_data_reduce_size.ps1

docker commit unittestdb sqlpass.azurecr.io/mssql-dev-db-image:latest

docker push sqlpass.azurecr.io/mssql-dev-db-image:latest

