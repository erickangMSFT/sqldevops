#!/bin/bash
#wget https://raw.githubusercontent.com/exAspArk/docker-alpine-ruby/master/gemrc
docker build . --rm -t slacker-node-runner:alpine

dt=`date '+%Y-%m-%d_%H-%M-%S'`
docker tag slacker-node-runner:alpine ericskang/slacker-node-runner:$dt
docker tag ericskang/slacker-node-runner:$dt ericskang/slacker-node-runner:latest

docker push ericskang/slacker-node-runner:$dt
docker push ericskang/slacker-node-runner:latest
