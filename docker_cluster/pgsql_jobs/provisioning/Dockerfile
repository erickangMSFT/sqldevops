FROM alpine:latest

RUN apk add --update postgresql-client openssl unzip && rm -rf /var/cache/apk/*

WORKDIR /opt/pg-provisioning-job
COPY ./provisioning.sh .
RUN chmod +x ./provisioning.sh

