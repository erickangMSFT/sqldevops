FROM postgres:alpine

ENV POSTGRES_USER=sa
ENV POSTGRES_PASSWORD Yukon900

RUN apk add --update unzip ca-certificates openssl && update-ca-certificates && rm -rf /var/cache/apk/*

WORKDIR /backup
RUN wget https://ftp.postgresql.org/pub/projects/pgFoundry/dbsamples/pagila/pagila/pagila-0.10.1.zip
RUN unzip ./pagila-0.10.1.zip

WORKDIR /opt/var/provisioning_scripts
#RUN wget https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/data_sanitization/sql/restore.sql
#RUN wget https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/data_sanitization/sql/adventureworks-restore.sql

EXPOSE 5432

CMD ["postgres"]
