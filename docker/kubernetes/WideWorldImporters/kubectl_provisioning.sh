#!/bin/bash

#creating new namespace 
kubectl create -f ./yaml/namespace.yaml
kubectl get namespaces
export KUBE_NAMESPACE=sqldevops
echo "namespace:" $KUBE_NAMESPACE

# create docker-registry key per namespace
# kubectl create secret docker-registry myregistrykey --docker-server=DOCKER_REGISTRY_SERVER --docker-username=DOCKER_USER --docker-password=DOCKER_PASSWORD --docker-email=DOCKER_EMAIL

kubectl create -f ./yaml/deployment.yaml
watch kubectl get all -n sqldevops
export POD_NAME=mssql-3396410544-681mj
# check pod

#execution of command (e.g. env) in a pod
kubectl exec -ti $POD_NAME -n $KUBE_NAMESPACE bash

