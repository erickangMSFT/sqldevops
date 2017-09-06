# sqldevops

## Available Demos

- UnitTest database initialization - sanitize data with Dynamic Data Masking and including schema and reference table data only
    * mssql-scipter to create a database with schema only.
    * bcp out and bcp in only reference table data
    * [demo](./data_sanitization)

- UnitTest for WideWorldImporters
    * RSpecs for WideWorldImporters WebSite SPs.
    * Slacker framework with tiny_tds driver support.
    * [demo folder](./tests/WideWorldImporters)

- Massively Parallel Testing with Slacker framework, containers, ACR and ACS with Kubernetes
    * docker container for unit test datbase (mssql) 
    * docker container for application (wwiapp)
    * docker container for slacker test runner (slacker)
        * todo: build one. Need to build a new images with slacker dependencies - rbenv, ruby etc then build slacker_runner test project container
    * ACR for sqldevops
    * Kubernetes cluster
        * mssql service and deployment with StatefullSet - ClusterIP and PersistentVolume mounting to Azure File disk
        * wwiapp service and deployment with Stateless Loadbalancer - External IP
        * slackerrunner service and deployment with Stateless Loadbalancer - ClusterIP
        * slackercontrol service and deployment with Stateless - External IP
    * Spin up and spin down for slacker_runner pods to loadbalance.
    * [demo folder](./docker/kubernetes/WideWorldImporters)
    * [test runner](./testrunner)

- Docker containerization 
    * Todo: include Docker Compose scenarios
    * [demo folder](./docker)
    * [demo file](./docker/docker_wwi.sh)

- Demo web application - WidWorldImporters (node.js)
    * [demo folder](./web)

- CI and CD automation for all above scenarios

## Missing demos 

8. Develop database and publish the change back to production

9. Containerization (cluster included) with persistent volume setup for statefulset



    * Enable Dynamic Data Masking on pre-prod database
    * mssql-scripter to turn dynamic masking into a static masking in dev / test database
    * reduced database schema and size using mssql-scripter --include-dependencies and --include-objects options
    * [demo file](./docker/demo.sh)