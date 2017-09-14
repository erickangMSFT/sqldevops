#!/bin/bash

docker build . --rm -t ericskang/db-provisioning-job:mssql
docker push ericskang/db-provisioning-job:mssql 

docker rmi -f $(docker images -f "dangling=true" -q)
