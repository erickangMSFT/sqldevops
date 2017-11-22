#!/bin/sh

kubectl apply -f ./deployment.yaml
kubectl apply -f ./class.yaml
kubectl apply -f ./auth/serviceaccount.yaml
kubectl apply -f ./auth/clusterrole.yaml
kubectl apply -f ./auth/clusterrolebinding.yaml

kubectl patch deployment nfs-client-provisioner -p '{"spec":{"template":{"spec":{"serviceAccount":"nfs-client-provisioner"}}}}'

