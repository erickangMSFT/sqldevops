FROM microsoft/mssql-server-linux:latest

ENV SA_PASSWORD Yukon900
ENV ACCEPT_EULA: Y
ENV MSSQL_PID Developer

WORKDIR /var/opt/mssql/backup
RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v0.2/WideWorldImporters-Full.bak

WORKDIR /opt/init_db
COPY restore_wwi.sh .
RUN chmod +x ./restore_wwi.sh

ENV MSSQLTOOLS_ROOT /opt/mssql-tools
ENV MSSQL_ROOT /opt/mssql

ENV PATH "$MSSQL_ROOT/bin:$MSSQLTOOLS_ROOT/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

CMD /opt/mssql/bin/sqlservr