#!/bin/bash

sqlcmd -Smssql -Usa -PSqlDevOps2017 -i ./restore.sql
sqlcmd -Smssql -Usa -PSqlDevOps2017 -i ./adventureworks-restore.sql