#!/bin/bash

#create a new container - sqlpass and sqlpassdev
docker run --name sqlpass -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Yukon900' -p 1433:1433 -v /azurebackups:/azurebackups -d microsoft/mssql-server-linux  

sleep 10

#restore db
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Yukon900 -i restore.sql 

#mask sensitive user data
/opt/mssql-tools/bin/sqlcmd -S localhost -d AdventureWorks -U sa -P Yukon900 -i ddm.sql 

#create script user without unmask permission
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Yukon900 -i create_user.sql 




