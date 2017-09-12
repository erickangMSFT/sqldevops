#!/bin/bash

# this demo script is based on 
# local kubernetes cluster setup 
# deployed sqldevops namespace
# and slacker service is deployed as NodePort type

kubectl get services -n sqldevops
kubectl describe nodes | grep -e 'Name:' -e 'IP' -e 'slacker' -e 'webapp' -e 'sqltools' -e 'mssql'
