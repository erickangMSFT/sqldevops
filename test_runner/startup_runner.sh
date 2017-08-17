#!/bin/bash

docker-compose build
docker-compose up -d
docker rmi -f $(docker images -f "dangling=true" -q)

curl localhost:8888