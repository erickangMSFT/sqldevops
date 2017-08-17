FROM microsoft/mssql-server-linux:latest
WORKDIR /var/opt/mssql/backup
RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v0.2/WideWorldImporters-Full.bak
CMD /opt/mssql/bin/sqlservr