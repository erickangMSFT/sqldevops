FROM microsoft/mssql-server-linux:latest

ENV SA_PASSWORD SqlDevOps2017
ENV MSSQL_PID Developer

ENV MSSQLTOOLS_ROOT /opt/mssql-tools
ENV PATH "$MSSQLTOOLS_ROOT/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

WORKDIR /var/opt/mssql/backup
RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v0.2/WideWorldImporters-Full.bak

WORKDIR /opt/var/scripts
RUN wget https://github.com/erickangMSFT/sqldevops/blob/master/data_sanitization/sql/restore.sql

CMD /opt/mssql/bin/sqlservr 
