#!/bin/bash

# setup minikube - full installation guide: https://kubernetes.io/docs/getting-started-guides/minikube/#installation
# 1. install virtualbox from https://www.virtualbox.org/wiki/Downloads
# 2. install kubectl https://kubernetes.io/docs/tasks/tools/install-kubectl/
# 3. install minikube https://github.com/kubernetes/minikube/releases 
# 4. start minikue cluster
minikube start
# 5. run the initial kubectl config
kubectl config use-context minikube
# 6. start dashboard
minikube dashboard

##################
## Docker image repository: Dockerfiles are linked in each repository
# demodb image:         https://hub.docker.com/r/ericskang/demodb/
# db provisioning job:  https://hub.docker.com/r/ericskang/db-provisioning-job/
# scheduled backup job: https://hub.docker.com/r/ericskang/cronjobs/
# db change deploy job: https://hub.docker.com/r/ericskang/db-jobs/
# webapp:               https://hub.docker.com/r/ericskang/webapp/

# git clone this repository to the current directory
git clone https://github.com/erickangMSFT/sqldevops.git
cd ./sqldevops/docker_cluster/kubernetes/prod_db

################
### Initial mssql pod setup

# create namespace: production
kubectl apply -f namespace.yml

# create persistent volume (pv)
kubectl apply -f persistent_volume/pv-host.yml

# (optional) check persistent volume
kubectl get pv

# deploy mssql pod using pv
kubectl apply -f sql-pv-host.yml

# (optional) check the progress for mssql pod creation
kubectl get all -n production

# (optional) check the progress for persistent volumeclaim creation
kubectl get pv
kubectl describe pvc sqlpvclaim -n production

#####################
### k8s Job system

# create database provisioning job and deploy user databases. demo for job-to-complete
kubectl apply -f ./jobs/provisioning/sql-provisioning.yml

# check the database creation
kubectl get pods -a -n production
kubectl logs <name of provisioniing pod e.g. sql-provisioning-hrs0w> -n production

# clean up the completed provisioning job
kubectl delete -f ./jobs/provisioning/sql-provisioning.yml

# (optional) check the database in sql server instance
kubectl get services -n production
kubectl describe nodes | grep -e 'Addr' -e 'Name:'

sqlcmd -S<node_address_ip>,31433 -Usa -PYukon900 -Q 'select name from sys.databases' # node port number is assigned to 31433

# enable full backup job every 24hours. demo for cronjob for scheduled backups.
kubectl apply -f kubectl apply -f jobs/business-continuity/sql-scheduled-backup.yml

# (optional) kubernetes cronjob simulation for log backup. runs every 60 sec
kubectl apply -f jobs/business-continuity/sql-scheduled-logbackup.yml

sleep 61 # wait 61 sec for the cron job to execute

# check the cronjob log
# first get the pod name for the completed job and view the log 
kubectl get pods -a -n production | grep -e 'sql-log-backup'
kubectl logs <pod_name> -n production

# delete the log backup simulation
kubectl delete -f jobs/business-continuity/sql-scheduled-logbackup.yml

######################
##### Database persistency
# simulate failure and data persistency. here we will kill the pod running sql server instance and recreate it. then check there was
# no data loss.

# 1. create demo web app for a visual demo.
kubectl apply -f web.yml

# 2. open web browser and go to <node_address_id>:30080/dbsize  e.g. http://kubernetes:30080/dbsize or http://10.128.19.19:30080/dbsize

# 3. delete mssql pod to simulate the failure. you can do it in dashboard ui as well. > minikube dashboard
kubectl delete pods mssql -n production

# 4. check the mssql pod is terminated
watch kubectl get pods -n production

# 5. recreate mssql pod without provisioning user data
kubectl apply -f sql-pv-host.yml
watch kubectl get pods -n production

# 6. check the web app http://<node_adress_ip>:30080/dbsize or run 
sqlcmd -S<node_address_id>,31433 -Usa -PYukon900 -Q 'select name from sys.databases'

#####################
##### Database change management (migration-script based)
# 1. this migration fixes a bug in Website.InsertCustomerOrders which inserts a broken order record when StockItemID value is invalid.
# the full database change mgmt project is at:
git clone https://github.com/erickangMSFT/wwi-db.git

# 2. deploying changes to the WWI using kubernetes job automation
kubectl apply -f mssql/jobs/migration/sql-db-migration.yml

# 3. check the job status 
kubectl get pods -a -n production | grep -e 'db-migration'

# 4. view the database migration log. e.g  kubectl logs db-migration-job-p3rrd -n production
kubectl logs <pod_name> -n production

# 5. clean-up the migration job
kubectl delete -f mssql/jobs/migration/sql-db-migration.yml
# done
