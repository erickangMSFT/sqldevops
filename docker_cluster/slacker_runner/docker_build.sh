#!/bin/bash

docker build . --rm -t slacker-node-runner:alpine

docker rmi -f $(docker images -f "dangling=true" -q)

docker images
