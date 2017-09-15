#!/bin/bash

kubectl create -f ./namespace.yaml
kubectl get namespaces
export KUBE_NAMESPACE=sqldevops

kubectl create secret docker-registry mykey --docker-username=$myusername --docker-password=$mypassword --docker-email=$myemail -n sqldevops

# deploy mssql and unittest cluster definition
kubectl create -f wwi_unittest.yml

# scaling
kubectl scale deployment slacker --replicas=2 -n sqldevops
watch kubectl get pods -n sqldevops

kubectl scale deployment webapp --replicas=1 -n sqldevops
watch kubectl get pods -n sqldevops

# run the following commands to update the pod with a newer version of docker image.
kubectl set image deployment/slacker-runner \
slacker-runner=sqldevopsacs.azurecr.io/slacker-node-runner -n sqldevops

# management: to access the pod run the following command.
kubectl get pods -n $KUBE_NAMESPACE
export POD_NAME=<pod_name e.g mssql-3396410544-681mj>
kubectl exec -ti $POD_NAME -n $KUBE_NAMESPACE bash