#!/bin/bash

docker build . --rm -t ericskang/cronjobs:backup
docker push ericskang/cronjobs:backup

docker rmi -f $(docker images -f "dangling=true" -q)
