#!/bin/bash

docker build . --rm -t mssql-unittest:latest
docker rmi -f $(docker images -f "dangling=true" -q)