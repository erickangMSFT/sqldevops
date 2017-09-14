FROM alpine:latest

RUN apk add --update postgresql-client openssl unzip && rm -rf /var/cache/apk/*

WORKDIR /opt/pg-provisioning-job

RUN wget https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/docker_cluster/pgsql_jobs/provisioning/provisioning.sh
RUN chmod +x ./provisioning.sh

