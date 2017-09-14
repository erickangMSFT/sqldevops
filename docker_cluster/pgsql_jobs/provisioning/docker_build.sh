#!/bin/bash

docker build . --rm -t ericskang/db-provisioning-job:pgsql
docker push ericskang/db-provisioning-job:pgsql 

docker rmi -f $(docker images -f "dangling=true" -q)
