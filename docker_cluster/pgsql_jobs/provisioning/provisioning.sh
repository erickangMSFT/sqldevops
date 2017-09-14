#!/bin/sh

print ** downloading pagila sample database
wget -q https://ftp.postgresql.org/pub/projects/pgFoundry/dbsamples/pagila/pagila/pagila-0.10.1.zip
unzip ./pagila-0.10.1.zip
rm ./pagila-0.10.1.zip

print ** creating pagila database
psql -h pgsql -U sa -c "CREATE DATABASE pagila;"

print ** creating schema in pagila database
psql -h pgsql -U sa -f ./pagila-0.10.1/pagila-schema.sql pagila 

print ** inserting data to pagila database
psql -h pgsql -U sa -f ./pagila-0.10.1/pagila-insert-data.sql pagila
