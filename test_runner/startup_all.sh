#!/bin/bash

docker-compose build
docker-compose up -d

docker rmi -f $(docker images -f "dangling=true" -q)

cd unittest_db
bash ./restore.sh

cd ../tests/init_db
powershell ./init_unittest_db.ps1

curl http://localhost:8888

