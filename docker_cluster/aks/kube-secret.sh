#!/bin/bash
kubectl create secret docker-registry mykey --docker-server=index.docker.io --docker-username=<here> --docker-password=<here> --docker-email=<and here> -n production