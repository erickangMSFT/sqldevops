# sqldevops demo

## Pre-req

- install [Docker](https://www.docker.com/)
- create a docker hub account and send an email to erickang at microsoft dot com to get the access permission for [WideWorldImporters unittest docker image](https://hub.docker.com/r/ericskang/unittestdb/)
    - otherwise, you can just build your own docker image using [docker_cluster/mssql_unittest/docker_build_push.sh](./docker_cluster/mssql_unittest/docker_build_push.sh)

## Demo

### Bootstrap dev and test enviroment as a developer
As a developer, you can build the entire dev and test environment for database, application and test in a few seconds.
1. simply run the following commands:

```bash
cd ./docker_cluster/docker-compose
docker-compose up -d
docker ps
```

    That's it. check docker-compose file [./docker_cluster/docker-compose/docker-compose.yml](./docker_cluster/docker-compose/docker-compose.yml)
```sqltools``` cotainer has pre-installed sqlcmd, bcp and mssql-scripter.

```bash
docker exec -ti sqltools bash
``` 



2. Open web browser and check following:
    * demo webapp [http://localhost](http://localhost)
        * check people information page for the result of data sanitization with dynamic data masking [http://localhost/Directory](http://localhost/Directory)
    
    * demo wideworldimporters unittest [http://localhost:8000](http://localhost:8000)
        * click each link on the index page

### Container-centric cluster
Enable parallel testing with kunbernetes cluster: note that parallel testing implementation is a demo purpose only.
URL to [Azure Container Registry](https://ms.portal.azure.com/#resource/subscriptions/d513e2e9-97db-40f6-8d1a-ab3b340cc81a/resourceGroups/sqldevopsGroup/providers/Microsoft.ContainerRegistry/registries/sqldevopsACS/overview) for this demo: 


0. install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 

1. create Azure container service. Or you can use minikube to play locally. [miniKube](https://kubernetes.io/docs/getting-started-guides/minikube/)

* open the [source folder](./docker_cluster/kubernetes_unittest_cluster)
* it can be fully automated but you will need to provide values for the settings first
* or just run the script line-by-line for demo

```bash
code ./docker_cluster/kubernetes_unittest_cluster/acs_provisioning.sh
vim ./docker_cluster/kubernetes_unittest_cluster/acs_provisioning.sh
```
> I assume you already have visual studio code installed. use vim otherwise.
> To install azure-cli, go to [https://github.com/Azure/azure-cli](https://github.com/Azure/azure-cli)

2. open kubernetes dashboard

```bash
kubectl proxy
```
Open dashboard [http://127.0.0.1/ui] and check the settings

3. run all tests in single pod 

```bash
cd ./test_controller

# modify node_runner_url='http://localhost:8000' 
# to extenal IP assigned by Kubernetes for slacker_runner service
./run_tests.sh
```
Total execution time would be ~10 seconds


4. increase the number of pods to 2 and run the same test again
use kubernetes dashboard / deployment / slacker pods property or run the following command:

```bash 
# spining up / down

kubectl scale deployment slacker-runner --replicas=2 -n sqldevops
watch kubectl get pods -n sqldevops-dev

kubectl scale deployment slacker-runner --replicas=1 -n sqldevops
watch kubectl get pods -n sqldevops-dev

```

## Data sanitization details

* source folder: [data_sanitization](./data_sanitization)
* automation script: [./data_sanitization/create_unittest_db.ps1](./data_sanitization/create_unittest_db.ps1)
* key take aways
    * the solution is defined in powershell script and automated. automation sample: [./docker_cluster/mssql_unittest/docker_build_push.sh](./docker_cluster/mssql_unittest/docker_build_push.sh)
        * intentionally used powershell for linux for demo. it can be defined on bash or python.
    * show the use of sqlcmd and bcp
    * show the use of mssql-scripter
    * data sanitization flow
        * restore pre-prod using prod backup or clone
        * enable dynamic data masking and create a low-previleged database user w.o UNMASK permission
        * mssql-scripter to dump schema
        * regex to modify the database name and reduce the database size from 4GB total to a few MB.
        * bcp out reference data only with the low-previleged user to convert dynamic data masking to static data masking
        * create database using mssql-scripter dump script and bcp in reference data only.

## Docker image build process details

* source folder: [docker_cluster](./docker_cluster)
    * Unittest database creation [Dockerfile](./docker_cluster/mssql_unittest/Dockerfile) [Shell script](./docker_cluster/mssql_unittest/docker_build_push.sh)

    * demo webapp: [Dockerfile](./web_app/Dockerfile)

    * slacker-node-runner (web based test runner): [Dockerfile](./docker_cluster/slacker_runner/Dockerfile)

    * slacker (framework only): [Dockerfile](./docker_cluster/slacker/Dockerfile)

* Docker hub repositories

    * https://hub.docker.com/r/ericskang/unittestdb/tags/ (private)

    * https://hub.docker.com/r/ericskang/webapp/tags/ (public)

    * https://hub.docker.com/r/ericskang/slacker-node-runner/tags/ (public)

    * https://hub.docker.com/r/ericskang/mssql-slacker/tags/ (public)






(TBD:below)

- Crete UnitTest Database: sanitize data with Dynamic Data Masking and including schema and reference table data only
    * mssql-scipter to create a database with schema only.
    * bcp out and bcp in only reference table data
    * [demo](./data_sanitization)

- UnitTest for WideWorldImporters
    * RSpecs for WideWorldImporters WebSite SPs.
    * Slacker framework with tiny_tds driver support.
    * [demo folder](./tests/WideWorldImporters)

- Parallel Testing with Slacker framework, containers, ACR and ACS with Kubernetes
    * docker container for unit test datbase (mssql) 
    * docker container for application (wwiapp)
    * docker container for slacker test runner (slacker)
    * ACR for sqldevops
    * Kubernetes cluster
        * mssql service and deployment with StatefullSet - ClusterIP and PersistentVolume mounting to Azure File disk
        * wwiapp service and deployment with Stateless Loadbalancer - External IP
        * slackerrunner service and deployment with Stateless Loadbalancer - ClusterIP
        * slackercontrol service and deployment with Stateless - External IP
    * Spin up and spin down for slacker_runner pods to loadbalance.
    * [demo folder](./docker_cluster/kubernetes_unittest_cluster)
    * [test runner](./sqldevops/test_runner)
    * [test controller] (./test_controller)

- Docker containerization
    * [demo folder](./docker_cluster)

- Demo web application - WidWorldImporters (node.js)
    * [demo folder](./web_app)

- CI and CD automation for all above scenarios

## Missing demos 

8. Develop database and publish the change back to production

9. Containerization (cluster included) with persistent volume setup for statefulset



    * Enable Dynamic Data Masking on pre-prod database
    * mssql-scripter to turn dynamic masking into a static masking in dev / test database
    * reduced database schema and size using mssql-scripter --include-dependencies and --include-objects options
    * [demo file](./docker/demo.sh)
