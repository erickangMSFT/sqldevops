#!/bin/bash

sqlcmd -Ssql -Usa -PYukon900 -i ./restore.sql
sqlcmd -Ssql -Usa -PYukon900 -i ./adventureworks-restore.sql