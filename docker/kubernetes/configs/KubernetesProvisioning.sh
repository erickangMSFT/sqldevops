#!/bin/bash

az account list
az account set -s <your subscription name>

az group create -n sqldevops-demo-kubernetes -l westus

az acs create -n sqldevops-cluster \
-g sqldevops-demo-kubernetes \
--dns-prefix sqldevops-cluster \
--orchestrator-type kubernetes \
--agent-count 1

az acs kubernetes get-credentials -n sqldevops-cluster -g sqldevops-demo-kubernetes

kubectl create -f wwi_unittest.yml


kubectl set image deployment/slacker-runner \
slacker-runner=sqldevopsacs.azurecr.io/slacker-node-runner -n sqldevops