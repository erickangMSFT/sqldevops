#!/bin/bash
createdb -U sa pagila
psql -U sa -f /backup/pagila-0.10.1/pagila-schema.sql pagila 
psql -U sa -f /backup/pagila-0.10.1/pagila-insert-data.sql pagila
