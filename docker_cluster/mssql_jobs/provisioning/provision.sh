#!/bin/bash

sqlcmd -Smssql -Usa -PYukon900 -i ./restore.sql
sqlcmd -Smssql -Usa -PYukon900 -i ./adventureworks-restore.sql