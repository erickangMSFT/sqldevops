#!/bin/bash

# script out a subset of database that application needs
/usr/local/bin/mssql-scripter -S localhost -d AdventureWorks -U scripter -P Yukon900 --include-objects HumanResources.uspGetDirectReports HumanResources.uspGetDirectManager --include-dependencies --include-types Schema --exclude-extended-properties --schema-and-data --script-create -f ./script.sql

