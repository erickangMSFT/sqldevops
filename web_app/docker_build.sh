#!/bin/bash

dt=`date '+%Y-%m-%d_%H-%M-%S'`
docker build . --rm -t ericskang/webapp:$dt
docker tag ericskang/webapp:$dt ericskang/webapp:latest

docker push ericskang/webapp:$dt
docker push ericskang/webapp:latest

# docker rmi -f $(docker images -f "dangling=true" -q)

# docker rmi -f ericskang/webapp:$dt
# docker rmi -f ericskang/webapp:latest
# docker rmi -f node:alpine
