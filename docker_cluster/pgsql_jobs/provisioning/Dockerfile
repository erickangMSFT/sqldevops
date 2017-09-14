FROM alpine:latest

RUN apk add --update postgresql-client openssl && rm -rf /var/cache/apk/*

RUN wget https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/docker_cluster/pgsql_jobs/provisioning/provisioning.sh
