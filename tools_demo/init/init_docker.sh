#!/bin/bash

# This script starts mssql and postgres containers.

# pull docker images
docker pull microsoft/mssql-server-linux:latest
docker pull postgres:latest
docker images

# start mssql container using persistent volume and restart always option
docker run --name mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=SqlDevOps2017' \
--cap-add SYS_PTRACE -p 1433:1433 -v sqlvol:/var/opt/mssql \
--restart=always -d microsoft/mssql-server-linux


# start pgsql container
docker run --name postgres -e POSTGRES_USER=sa -e POSTGRES_PASSWORD=SqlDevOps2017 \
-p 5432:5432 --restart=always -d -v pgvol:/usr/local/pgsql/data postgres:latest

# check the running status of containers
docker ps
