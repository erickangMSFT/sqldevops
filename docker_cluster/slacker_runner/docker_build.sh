#!/bin/bash
#wget https://raw.githubusercontent.com/exAspArk/docker-alpine-ruby/master/gemrc
docker build . --rm -t slacker-node-runner:alpine

docker rmi -f $(docker images -f "dangling=true" -q)
