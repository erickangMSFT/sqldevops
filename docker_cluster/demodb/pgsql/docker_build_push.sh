#!/bin/bash

dt=`date '+%Y-%m-%d_%H-%M-%S'`

# initial build including wwi backup files and restore script
docker build . --rm -t demodb:pgsql

docker push ericskang/demodb:pgsql

docker rmi -f $(docker images -f "dangling=true" -q)

