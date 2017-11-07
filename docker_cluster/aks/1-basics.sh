docker pull microsoft/mssql-server-linux:latest

docker run --name demosqlserver \
    -p 1431:1433 \
    -e "ACCEPT_EULA=Y" \
    -e "SA_PASSWORD=SqlDevOps2017" \
    -e "MSSQL_PID=Developer" \
    -d microsoft/mssql-server-linux:latest

docker rm -f demosqlserver

docker-compose up -d

