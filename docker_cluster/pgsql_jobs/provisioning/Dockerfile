FROM alpine:latest

RUN apk add --update postgresql-client openssl unzip bash && rm -rf /var/cache/apk/*
ENV PGPASSWORD SqlDevOps2017

WORKDIR /opt/pg-provisioning-job
COPY ./provisioning.sh .
RUN chmod +x ./provisioning.sh

