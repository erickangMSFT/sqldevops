#!/bin/bash

# get cluster info
kubectl cluster-info

# get deployment info
kubectl get deployments -n sqldevops-dev

# get pods info
kubectl get pods -n sqldevops-dev 

# spining up / down

kubectl scale deployment mssql --replicas=4 -n sqldevops-dev

kubectl get pods -n sqldevops-dev 

kubectl scale deployment mssql --replicas=1 -n sqldevops-dev

kubectl get pods -n sqldevops-dev 
