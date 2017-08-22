FROM ericskang/mssql-slacker:latest
# Create app directory
WORKDIR /opt/var/slacker_runner
# Install app dependencies
COPY runner/package.json .
# COPY runner/package-lock.json .
RUN npm install --only=production
# Bundle app source
COPY runner/ .

# replace it with your slacker test project 
COPY ./tests/WideWorldImporters ./test 

CMD npm start