#!/bin/bash

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

kubectl create secret docker-registry mykey --docker-username=$myusername --docker-password=$mypassword --docker-email=$myemail -n sqldevops


# deploy mssql and unittest cluster definition
kubectl create -f wwi_unittest.yml

