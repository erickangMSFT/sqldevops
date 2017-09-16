#!/bin/bash

docker build . --rm --squash -t ericskang/db-provisioning-job:mssql
docker push ericskang/db-provisioning-job:mssql 

docker rmi -f $(docker images -f "dangling=true" -q)
