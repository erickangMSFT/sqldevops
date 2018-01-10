kubectl exec -ti mssql-0 -n production \
    bash -c 'cd /var/opt/mssql \
        && mkdir -p backup \
        && cd backup \
        && wget https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v0.2/WideWorldImporters-Full.bak \
        && wget https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/docker_cluster/aks/restore.sql \
        && /opt/mssql-tools/bin/sqlcmd -Usa -PSqlDevOps2017 -i restore.sql'
