FROM microsoft/mssql-server-linux:latest

ENV SA_PASSWORD SqlDevOps2017
ENV MSSQL_PID Developer

RUN apt-get update && apt-get install -y unzip

WORKDIR /tmp/backup
RUN wget -q https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v0.2/WideWorldImporters-Full.bak
RUN wget -q https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks2014/adventure-works-2014-oltp-full-database-backup.zip

RUN unzip ./adventure-works-2014-oltp-full-database-backup.zip
RUN rm ./adventure-works-2014-oltp-full-database-backup.zip

WORKDIR /opt/var/provisioning_scripts
RUN wget -q https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/data_sanitization/sql/restore.sql
RUN wget -q https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/data_sanitization/sql/adventureworks-restore.sql

CMD /opt/mssql/bin/sqlservr 
