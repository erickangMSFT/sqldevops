FROM ericskang/mssql-slacker:latest
# Create app directory
WORKDIR /opt/var/slacker_runner
# Install app dependencies
COPY runner/package.json .
# COPY runner/package-lock.json .
RUN npm install
# Bundle app source
COPY runner/ .
COPY ./tests/WideWorldImporters ./test
WORKDIR /opt/var/slacker_runner
EXPOSE 3000
CMD [ "node", "./bin/www" ]