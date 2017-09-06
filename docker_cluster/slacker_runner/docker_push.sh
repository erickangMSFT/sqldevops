#!/bin/bash

docker login

dt=`date '+%Y-%m-%d_%H-%M-%S'`
docker tag slacker-node-runner:alpine ericskang/slacker-node-runner:$dt
docker tag ericskang/slacker-node-runner:$dt ericskang/slacker-node-runner:latest

docker push ericskang/slacker-node-runner:$dt
docker push ericskang/slacker-node-runner:latest

docker rmi -f $(docker images -f "dangling=true" -q)
