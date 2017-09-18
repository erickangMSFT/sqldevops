#!/bin/bash

# setup minikube - full install guide: https://kubernetes.io/docs/getting-started-guides/minikube/#installation
# 1. install virtualbox from https://www.virtualbox.org/wiki/Downloads
# 2. install kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl/
# 3. install minikube https://github.com/kubernetes/minikube/releases 
# 4. start minikue cluster
    # minikube start / stop / delete
# 5. run the initial kubectl config
    # kubectl config use-context minikube
# 6. start dashboard
    # minikube dashboard

# create namespace: production
kubectl apply -f namespace.yml

# create persistent volume (pv)
kubectl apply -f persistent_volume/pv-host.yml

# check persistent volume
kubectl get pv

# deploy mssql pod using pv
kubectl apply -f sql-pv-host.yml

# check mssql pod creation
kubectl get all -n production

# check persistent volumeclaim creation
kubectl get pv
kubectl describe pvc sqlpvclaim -n production

# create database provisioning job and deploy user databases
kubectl apply -f ./jobs/provisioning/sql-provisioning.yml

# check the database creation
kubectl get pods -a -n production
kubectl logs <name of provisioniing pod e.g. sql-provisioning-hrs0w> -n production

# clean up the completed provisioning job
kubectl delete -f ./jobs/provisioning/sql-provisioning.yml

# optionally check the database in sql server instance
kubectl get services -n production
kubectl describe nodes | grep -e 'Addr' -e 'Name:'

sqlcmd -S<node_address_ip>,31433 -Usa -PYukon900 -Q 'select name from sys.databases' # node port number is assigned to 31433

# enable full backup job every 24hours
kubectl apply -f kubectl apply -f jobs/business-continuity/sql-scheduled-backup.yml

# to see the kubernetes cronjob simulation for log backup that runs every 60 sec
kubectl apply -f jobs/business-continuity/sql-scheduled-logbackup.yml

sleep 61 # wait 61 sec for the cron job to execute

# check the job log
# get the pod name for 
kubectl get pods -a -n production | grep -e 'sql-log-backup'
kubectl logs <pod_name> -n production

# delete the log backup simulation
kubectl delete -f jobs/business-continuity/sql-scheduled-logbackup.yml

# simulate failure and data persistency
# 1. create demo web app.
kubectl apply -f web.yml

# 2. open web browser and go to <node_address_id>:30080/dbsize  e.g. http://kubernetes:30080/dbsize

# 3. delete mssql pod to simulate the failure. you can do it in dashboard ui as well. > minikube dashboard
kubectl delete pods mssql -n production

# 4. check the mssql pod is terminated
watch kubectl get pods -n production

# 5. recreate mssql pod without provisioning user data
kubectl apply -f sql-pv-host.yml
watch kubectl get pods -n production

# 6. check the web app http://<node_adress_ip>:30080/dbsize or run 
sqlcmd -S<node_address_id>,31433 -Usa -PYukon900 -Q 'select name from sys.databases'

# done
