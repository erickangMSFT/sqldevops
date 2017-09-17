#!/bin/bash
kubectl version
kubectl cluster-info
kubectl get nodes

#create a deployment
kubectl run <deployment-name> --image=<docker image name> --port=8080

#get the name of pod
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

#get kube namespaces and pods
kubectl get namespaces
kubectl get pods -n <namespace>

export KUBE_NAMESPACE=<namespace>
kubectl get pods -n $KUBE_NAMESPACE
kubectl describe pods -n $KUBE_NAMESPACE
export POD_NAME=<podname>
kubectl logs $POD_NAME -n $KUBE_NAMESPACE | grep 'Server name'

#execution of command (e.g. env) in a pod
kubectl exec $POD_NAME -n $KUBE_NAMESPACE env
kubectl exec -ti $POD_NAME -n $KUBE_NAMESPACE bash

# reference accessing pods and containers : https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/

# services
kubectl get services -n $KUBE_NAMESPACE
export KUBE_SERVICE=<service name>
# new service
kubectl expose deployment/<deployment name> --type="ClusterIP" --port <port number>


#get pods and services by deployment name
kubectl get deployment -n $KUBE_NAMESPACE
export KUBE_DEPLOYMENT=<deployment>
kubectl get pods -l run=$KUBE_DEPLOYMENT
kubectl get services =l run=$KUBE_DEPLOYMENT

#all just get all
kubectl get all -n $KUBE_NAMESPACE

#assign label to pod
kubectl label pod $POD_NAME app=v1 #appname=version

#deleting service
kubectl delete service -l run=$KUBE_SERVICE


#scaling up and down
kubectl scale deployment/$KUBE_DEPLOYMENT --replicas=4 -n $KUBE_NAMESPACE
watch kubectl get pods -n $KUBE_NAMESPACE

kubectl scale deployment/$KUBE_DEPLOYMENT --replicas=1 -n $KUBE_NAMESPACE
watch kubectl get pods -n $KUBE_NAMESPACE


# rolling out updates of app and db
kubectl set image deployments/$KUBE_DEPLOYMENT $KUBE_DEPLOYMENT=<image_name>

# rollout undo
kubectl rollout undo deployments/$KUBE_DEPLOYMENT


# create deployment and service using yaml
kubectl create -f <path_to_yaml_file>
kubectl apply -f <path_to_updated_yaml_file>

kubectl delete deployment <deploment name>