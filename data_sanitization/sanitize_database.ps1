
sqlcmd -S $hostname -Usa -P SqlDevOps2017 -i ./sql/restore.sql 

sqlcmd -S $hostname -dWideWorldImporters -U sa -P SqlDevOps2017 -i ./sql/dynamic_data_masking.sql 

mssql-scripter -S $hostname -dWideWorldImporters -Usa -PSqlDevOps2017 > ./out/create_wwi.sql

./bcp_out_reference_tables.ps1

sqlcmd -S $hostname -Usa -PSqlDevOps2017 -i ./out/create_wwi.sql

./bcp_in_reference_tables.ps1



