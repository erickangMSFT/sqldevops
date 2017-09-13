RUN microsoft/mssql-server-linux:latest

ENV SA_PASSWORD Yukon900
ENV MSSQL_PID Developer

WORKDIR /var/opt/mssql/backup
RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v0.2/WideWorldImporters-Full.bak
RUN wget https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks2014/adventure-works-2014-oltp-full-database-backup.zip

RUN unzip ./adventure-works-2014-oltp-full-database-backup.zip

WORKDIR /opt/var/provisioning_scripts
RUN wget 
RUN wget 

CMD /opt/mssql/bin/sqlservr 