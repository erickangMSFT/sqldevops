#!/bin/bash

docker login

dt=`date '+%Y-%m-%d_%H-%M-%S'`
echo $dt
docker tag slacker:alpine ericskang/mssql-slacker:$dt
docker tag ericskang/mssql-slacker:$dt ericskang/mssql-slacker:latest

docker push ericskang/mssql-slacker:$dt
docker push ericskang/mssql-slacker:latest

docker rmi -f $(docker images -f "dangling=true" -q)
