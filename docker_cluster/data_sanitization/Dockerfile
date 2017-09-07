FROM ubuntu:latest


RUN apt-get install -y mssql-tools unixodbc-dev


WORKDIR /opt/var/scripts
RUN wget https://github.com/erickangMSFT/sqldevops/blob/master/data_sanitization/sql/restore.sql
RUN wget https://:wq

CMD /opt/mssql/bin/sqlservr 
