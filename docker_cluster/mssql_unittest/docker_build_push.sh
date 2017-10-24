#!/bin/bash

# initial build including wwi backup files and restore script
docker build . --rm -t mssql-unittest:temp

# start a docker container to further build layers.
docker run --name unittestdb -e "ACCEPT_EULA=Y" -p 1433:1433 -d mssql-unittest:temp

# sql server needs 10 to 15 seconds to bootup
sleep 15

docker ps

echo 'starting data sanitization'
cd ../../data_sanitization
powershell ./create_unittest_db.ps1

dt=`date '+%Y-%m-%d_%H-%M-%S'`

docker commit unittestdb ericskang/unittestdb:$dt
docker tag ericskang/unittestdb:$dt ericskang/unittestdb:latest

docker push ericskang/unittestdb:$dt
docker push ericskang/unittestdb:latest
