#!/bin/bash

# this demo script is based on 
# local kubernetes cluster setup 
# deployed sqldevops namespace
# and slacker service is deployed as NodePort type

kubectl get services -n $kube_namespace 
kubectl describe nodes | grep -e 'Name:' -e 'IP' -e 'Addresses' -e 'slacker' -e 'webapp' -e 'sqltools' -e 'mssql'
