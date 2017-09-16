#!/bin/bash

docker build . --rm --squash --compress -t ericskang/sqltools:sqlcmd

docker login

docker push ericskang/sqltools:sqlcmd

docker rmi -f $(docker images -f "dangling=true" -q)
