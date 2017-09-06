#!/bin/bash

# create a subnet network for containers to communicate (e.g. between node web app and mssql database)
# e.g. docker network create -d bridge --subnet 10.234.0.0/16 mynetwork

# or simply run the following commands
docker network create mynet
docker network list

# add containers to the subnet network

docker network connect mynet mssql
docker network connect mynet wwiapp

# check if restarting container is required step to make the network config effective.
docker restart mssql
docker restart wwiapp

docker network inspect mynet

