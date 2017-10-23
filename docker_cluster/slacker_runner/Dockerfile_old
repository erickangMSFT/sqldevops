FROM node:boron-alpine
RUN apk add --update freetds freetds-dev unixodbc-dev bash git curl build-base readline-dev openssl-dev zlib-dev && rm -f /var/cache/apk/*


# rbenv
ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv
ENV RUBY_VERSION 2.4.1
ENV CONFIGURE_OPTS --disable-install-doc

RUN apk add --update \
    linux-headers \
    imagemagick-dev \    
    libffi-dev \    
    libffi-dev \
&& rm -rf /var/cache/apk/*

RUN git clone --depth 1 git://github.com/sstephenson/rbenv.git ${RBENV_ROOT} \
&&  git clone --depth 1 https://github.com/sstephenson/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build \
&&  git clone --depth 1 git://github.com/jf/rbenv-gemset.git ${RBENV_ROOT}/plugins/rbenv-gemset \
&& ${RBENV_ROOT}/plugins/ruby-build/install.sh

RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh 

RUN rbenv install $RUBY_VERSION \
&&  rbenv global $RUBY_VERSION

RUN gem install bundler && gem install tiny_tds -f && gem install slacker

ENV TEST_GITFILE git://github.com/erickangMSFT/wwi-test.git
ENV RUNNER_GITFILE git://github.com/erickangMSFT/slacker-node-runner.git

WORKDIR /opt/slacker-test

RUN git clone ${TEST_GITFILE} .

WORKDIR /opt/slacker

RUN git clone ${RUNNER_GITFILE} .

RUN npm install --only=production

CMD npm start
