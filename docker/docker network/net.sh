#!/bin/bash

# create a subnet network for containers to communicate (e.g. between node web app and mssql database)
docker network create -d bridge --subnet 10.234.0.0/16 mynetwork
docker network list

# add containers to the subnet network

docker network connect mynet mssql

docker run --name wwiapp -p 80:3000 -d wwinodeapp
docker network connect mynet wwiapp
docker restart wwiapp
docker network inspect mynet

