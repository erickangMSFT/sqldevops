FROM alpine:latest

RUN apk add --update postgresql-client openssl unzip bash && rm -rf /var/cache/apk/*
ENV PGPASSWORD Yukon900

WORKDIR /opt/pg-provisioning-job
COPY ./provisioning.sh .
RUN chmod +x ./provisioning.sh

