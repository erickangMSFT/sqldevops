FROM ericskang/mssql-slacker:latest

WORKDIR /opt/var/slacker/wwi

COPY . .

RUN chmod +x ./runner.sh
RUN chmod +x ./wait-for-it.sh
CMD /bin/bash -c "tail -f /dev/null"