#!/bin/bash

# initial build including wwi backup files and restore script
docker build . --rm -t mssql-unittest:latest

# start a docker container to further build layers.

docker run --name unittestdb -p 1433:1433 -d mssql-unittest:latest

docker rmi -f $(docker images -f "dangling=true" -q)

