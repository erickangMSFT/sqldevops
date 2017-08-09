# sqldevops

## Upcoming events

1. Open Source Summit Sept 11 - is someone going here? 
    -  Puppet Conf in Oct
2. Linux TownHall - 8/24 sqldevops
3. Ignite - 9/25? Presenting with HPE for Nimble Storage about sqldevops
    - Tools session as well
4. SQLPass - sqldevops and CICD with SSDT & VSTS
5. MVP Summit - carbon and CLI tools
6. CONNECT 2017 - Carbon and others?

## Available Demos

1. Data sanitization - sanitize data by reducing size (schema and data) and adding sensitive data protection
    * Dynamic Data Masking
    * mssql-scripter to turn dynamic masking into a static masking in dev / test database
    * reduced database schema and size using mssql-scripter --include-dependencies and --include-objects options
    * [demo file](./docker/demo.sh)

2. UnitTest database initialization - sanitize data by including fully schema and reference table data only
    * mssql-scipter to create a database with schema only.
    * bcp out and bcp in only reference table data
    * [demo folder](./tests/init_db)

3. UnitTest for WideWorldImporters
    * RSpecs for WideWorldImporters WebSite SPs.
    * Slacker framework with tiny_tds driver support.
    * [demo folder](./tests/WideWorldImporters)

4. Massively Parallel Testing with Slacker framework, containers, ACR and ACS with Kubernetes
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

5. 'new tool' extension settings demo
    * [demo folder](./.vscode)
6. Docker containerization 
    * Todo: include Docker Compose scenarios
    * [demo folder](./docker)
    * [demo file](./docker/docker_wwi.sh)

7. Demo web application - WidWorldImporters (node.js)
    * [demo folder](./web)

8. CI and CD automation for all above scenarios

## Missing demos 

9. Develop database and publish the change back to production: Windows Only