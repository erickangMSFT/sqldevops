#!/bin/bash

# create a subnet network for containers to communicate (e.g. between node web app and mssql database)
docker network create -d bridge --subnet 10.234.0.0/16 mynetwork
docker network list

# add containers to the subnet network
docker network connect mynet wwiapp
docker network connect mynet mssql
docker restart wwiapp

docker network inspect mynet

