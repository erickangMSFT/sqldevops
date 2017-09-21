FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl apt-transport-https && apt-get clean

RUN curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && curl -s https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
ENV ACCEPT_EULA y 

RUN apt-get update && apt-get install -y mssql-tools unixodbc-dev locales \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get clean

ENV LANG en_US.utf8
ENV MSSQLTOOLS_ROOT /opt/mssql-tools
ENV PATH "$MSSQLTOOLS_ROOT/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

CMD tail -f /dev/null
