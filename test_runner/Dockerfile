FROM ericskang/mssql-slacker:latest

WORKDIR /opt/var/slacker_runner

COPY runner/package.json .

RUN npm install --only=production

COPY runner/ .

COPY ./tests/WideWorldImporters ./test 

CMD npm start