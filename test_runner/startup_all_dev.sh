#!/bin/bash

docker-compose build
docker-compose up -d

docker rmi -f $(docker images -f "dangling=true" -q)

docker exec -ti mssql_unittest bash ./restore_wwi.sh

cd unittest_db
bash ./restore.sh

cd ../tests/init_db
powershell ./init_unittest_db.ps1

curl http://localhost:8888/api/runall

