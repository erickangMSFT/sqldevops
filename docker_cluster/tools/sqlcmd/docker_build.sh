#!/bin/bash

dt=`date '+%Y-%m-%d_%H-%M-%S'`

docker build . --rm -t ericskang/sqltools:sqlcmd

docker login

docker push ericskang/sqltools:sqlcmd

docker rmi -f $(docker images -f "dangling=true" -q)
