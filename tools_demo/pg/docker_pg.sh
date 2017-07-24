#!/bin/bash

docker pull postgres:latest

docker run --name postgres -e POSTGRES_USER=sa -e POSTGRES_PASSWORD=Yukon900 -p 5432:5432 --restart=always -d postgres