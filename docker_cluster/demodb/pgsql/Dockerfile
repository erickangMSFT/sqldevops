FROM postgres:alpine

ENV POSTGRES_USER=sa
ENV POSTGRES_PASSWORD SqlDevOps2017

RUN apk add --update unzip ca-certificates openssl && update-ca-certificates && rm -rf /var/cache/apk/*

WORKDIR /backup
RUN wget -q https://ftp.postgresql.org/pub/projects/pgFoundry/dbsamples/pagila/pagila/pagila-0.10.1.zip
RUN wget -q https://raw.githubusercontent.com/erickangMSFT/sqldevops/master/docker_cluster/pgsql_jobs/provisioning/provisioning.sh
RUN chmod +x provisioning.sh
RUN unzip ./pagila-0.10.1.zip
RUN rm ./pagila-0.10.1.zip

EXPOSE 5432

CMD ["postgres"]
