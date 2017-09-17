FROM node:8.4-alpine
# Create app directory
WORKDIR /usr/src/app
# Install app dependencies
COPY package.json .
COPY package-lock.json .
RUN npm install --only=production
# Bundle app source
COPY . .
EXPOSE 3000
CMD [ "node", "./bin/www" ]