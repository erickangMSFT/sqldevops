FROM node:boron-alpine
RUN apk update && apk upgrade && \
apk --no-cache add ruby ruby-dev ruby-rdoc ruby-bundler ruby-json ruby-irb ruby-rake ruby-bigdecimal make gcc libc-dev freetds-dev unixodbc-dev ca-certificates git && \
rm -rf /var/cache/apk/*

# to avoid installing documentation for gems
COPY gemrc $HOME/.gemrc

# use mounted volume for gems
ENV BUNDLE_PATH /bundle& chmod 777 "$GEM_HOME" "$BUNDLE_BIN"
RUN gem install tiny_tds -f && gem install slacker

ENV TEST_GITFILE git://github.com/erickangMSFT/wwi-test.git
ENV RUNNER_GITFILE git://github.com/erickangMSFT/slacker-node-runner.git

WORKDIR /opt/slacker-test
RUN git clone ${TEST_GITFILE} .

WORKDIR /opt/slacker
RUN git clone ${RUNNER_GITFILE} . && \
  npm install --only=production

CMD npm start
