#!/bin/bash


dt=`date '+%Y-%m-%d_%H-%M-%S'`

docker build . --rm -t ericskang/sqltools:$dt

docker tag ericskang/sqltools:$dt ericskang/sqltools:latest

docker login

docker push ericskang/sqltools:$dt
docker push ericskang/sqltools:latest

docker rmi -f $(docker images -f "dangling=true" -q)
