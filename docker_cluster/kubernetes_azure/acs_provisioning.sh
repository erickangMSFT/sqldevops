#!/bin/bash

# login to Azure
az login

# list your subscriptions
az account list

# set a subscription as the default. Run this if you have multiple subscriptions for your azure login
az account set -s <your subscription name>

# create an azure group to provision acs
az group create -n sqldevops-erickang-kubernetes -l westus

# provision acs. change agent-count to 2 or more for a practical setup including azure loadbalancer
az acs create -n sqldevops-k8s \
-g erickang-kubernetes-acs \
--dns-prefix sqldevops-k8s \
--orchestrator-type kubernetes \
--agent-count 1

# run this to make your laptop to connect acs-k8s with kubectl
az acs kubernetes get-credentials -n sqldevops-cluster -g sqldevops-erickang-kubernetes

# check the status in K8s dashboard. access it using a web browser: 127.0.0.1/ui after running the following command
kubectl proxy

# Optional: create a new namespace 
kubectl create -f ./namespace.yaml
kubectl get namespaces
export KUBE_NAMESPACE=sqldevops

# Onetime-setup - run to use a private docker repository. Make sure to place the key in the same namespce with pods and services.
# sample - get the server, username and password from the private registry. For azure container registry, use portal.azure.net to retrieve the information
# kubectl create secret docker-registry mssqlkey 
# --docker-server=sqldevopsacs.azurecr.io 
# --docker-username=sqldevopsadmin 
# --docker-password=!#roalkdfjqweoruqwfasldfkjasf 
# --docker-email=sqldevopsadmin@myemail
 
kubectl create secret docker-registry mssqlkey \
--docker-server=<DOCKER_REGISTRY_SERVER> \
--docker-username=<DOCKER_USER> \
--docker-password=<DOCKER_PASSWORD> \
--docker-email=<DOCKER_EMAIL>
-n $KUBE_NAMESPACE

# deploy mssql and unittest cluster definition
kubectl create -f wwi_unittest.yml


###end of initial provisioning####

# run the following commands to update the pod with a newer version of docker image.
kubectl set image deployment/slacker-runner \
slacker-runner=sqldevopsacs.azurecr.io/slacker-node-runner -n sqldevops

# management: to access the pod run the following command.
kubectl get pods -n $KUBE_NAMESPACE
export POD_NAME=<pod_name e.g mssql-3396410544-681mj>
kubectl exec -ti $POD_NAME -n $KUBE_NAMESPACE bash