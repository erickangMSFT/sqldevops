RUN postgres:latest

ENV POSTGRES_USER=sa
ENV POSTGRES_PASSWORD Yukon900


WORKDIR /backup
RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v0.2/WideWorldImporters-Full.bak
RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks2014/adventure-works-2014-oltp-full-database-backup.zip

RUN unzip ./adventure-works-2014-oltp-full-database-backup.zip

WORKDIR /opt/var/provisioning_scripts
#RUN wget https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/data_sanitization/sql/restore.sql
#RUN wget https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/data_sanitization/sql/adventureworks-restore.sql

EXPOSE 5432

CMD tail -f /dev/null