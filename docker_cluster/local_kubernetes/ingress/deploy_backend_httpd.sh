#!/bin/sh

kubectl apply -f https://raw.githubusercontent.com/kubernetes/contrib/master/ingress/controllers/nginx/examples/default-backend.yaml -n sqldevops
kubectl expose rc default-http-backend --port=80 --target-port=8080 --name=default-http-backend -n sqldevops
