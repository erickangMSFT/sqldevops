#!/bin/bash

# get cluster / service / deployment and pod info
clear
kubectl cluster-info
kubectl get services -n sqldevops-dev
kubectl get deployments -n sqldevops-dev
kubectl get pods -n sqldevops-dev 

# spining up / down
clear
kubectl scale deployment mssql --replicas=10 -n sqldevops-dev
watch kubectl get pods -n sqldevops-dev

clear
kubectl scale deployment mssql --replicas=1 -n sqldevops-dev
watch kubectl get pods -n sqldevops-dev