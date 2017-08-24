#!/bin/bash

dt=`date '+%Y-%m-%d_%H-%M-%S'`
echo $dt

docker commit mssql_unittest wwi_test:temp
docker build ~/tests/init_db/Dockerfile --rm -t sqldevopsacs.azurecr.io/ww_test:$dt
docker tag sqldevopsacs.azurecr.io/ww_test:latest

dockr login sqldevopsacs.azurecr.io

docker push sqldevopsacs.azurecr.io/ww_test:$dt
docker push sqldevopsacs.azurecr.io/ww_test:latest
