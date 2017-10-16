#!/bin/bash

docker stack deploy -c docker-compose.yml sqldevops

docker stack ps sqldevops