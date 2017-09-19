#!/bin/bash

# initial build including wwi backup files and restore script
docker build . --rm -t ericskang/mssql-slacker:controller

docker login
docker push ericskang/mssql-slacker:controller

docker rmi -f $(docker images -f "dangling=true" -q)
