#!/bin/sh

RUN wget -q https://ftp.postgresql.org/pub/projects/pgFoundry/dbsamples/pagila/pagila/pagila-0.10.1.zip
RUN unzip ./pagila-0.10.1.zip
RUN rm ./pagila-0.10.1.zip

psql -h pgsql -U sa -c "CREATE DATABASE pagila;"
psql -h pgsql -U sa -f ./pagila-0.10.1/pagila-schema.sql pagila 
psql -h pgsql -U sa -f ./pagila-0.10.1/pagila-insert-data.sql pagila
