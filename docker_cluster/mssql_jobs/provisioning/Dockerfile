FROM ericskang/sqltools:latest

WORKDIR /opt/sql-provisioning-job

RUN wget -q https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/data_sanitization/sql/restore.sql
RUN wget -q https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/data_sanitization/sql/adventureworks-restore.sql

COPY ./provision.sh .
RUN chmod +x ./provision.sh

