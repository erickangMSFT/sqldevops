#!/bin/bash

docker build . --rm -t ericskang/slacker-lb:nginx
docker push ericskang/slacker-lb:nginx 

docker rmi -f $(docker images -f "dangling=true" -q)
