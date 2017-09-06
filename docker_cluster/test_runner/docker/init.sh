#!/bin/bash

# First, install docker and set the memory set to 4GB on Docer --> Preferences --> Advanced settings tab.

############### container provisioning ########################

# mssql container run following commands for it:
docker pull microsoft/mssql-server-linux:latest
docker run --name mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' --cap-add SYS_PTRACE --restart=always -p 1433:1433 -d microsoft/mssql-server-linux

# slacker container:
docker pull ericskang/mssql-slacker:latest
docker run --name slacker --restart=always -d ericskang/mssql-slacker:latest tail -f /dev/null

# setup network for two containers
docker network create -d bridge --subnet 10.234.0.0/16 mynet
docker network connect mynet mssql
docker network connect mynet slacker

# restart container to take the effect of network config.
docker restart mssql
docker restart slacker

########### end of provisioning ###############

# using slacker
docker exec -ti slacker /bin/bash

cd ~
slacker_new dbtest

cd dbtest
vim database.yml 

# change properties e.g. 

# ---
# server: mssql
# database: tempdb (or your test database)
# user: sa
# password: Yukon900
# port: 1433
# driver: tiny_tds
# ---

# run slacker
slacker