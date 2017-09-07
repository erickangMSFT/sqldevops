FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y curl apt-transport-https python python-pip vim
RUN pip install mssql-scripter

RUN curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl -s https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
ENV ACCEPT_EULA y 
ENV DEBIAN_FRONTEND noninteractive 

RUN apt-get update && apt-get install -y --no-install-recommends mssql-tools unixodbc-dev

CMD tail -f /dev/null
