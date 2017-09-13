#!/bin/bash

dt=`date '+%Y-%m-%d_%H-%M-%S'`

# initial build including wwi backup files and restore script
docker build . --rm -t demodb:mssql


docker login

docker push ericskang/demodb:mssql

docker rmi -f $(docker images -f "dangling=true" -q)
docker rmi -f demodb:mssql
