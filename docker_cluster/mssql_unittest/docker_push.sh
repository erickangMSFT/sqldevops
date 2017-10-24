#!/bin/bash
echo 'starting data sanitization'
cd ../../data_sanitization
powershell ./create_unittest_db.ps1

dt=`date '+%Y-%m-%d_%H-%M-%S'`

docker commit unittestdb ericskang/unittestdb:$dt
docker tag ericskang/unittestdb:$dt ericskang/unittestdb:latest

docker push ericskang/unittestdb:$dt
docker push ericskang/unittestdb:latest