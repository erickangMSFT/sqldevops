FROM ubuntu:latest

RUN apt-get update && apt-get -y install ca-certificates wget vim build-essential libc6-dev libssl-dev libreadline-dev zlib1g-dev unixodbc-dev --no-install-recommends apt-utils

WORKDIR /usr/src/slacker

COPY docker/git/rbenv /usr/local/rbenv
COPY docker/git/freetds-1.00.27 ./freetds-1.00.27

RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/plugins/ruby-build/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh

ENV RBENV_ROOT /usr/local/rbenv

ENV PATH "$RBENV_ROOT/bin:$RBENV_ROOT/shims:$RBENV_ROOT/plugins/ruby-build/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

WORKDIR /usr/src/slacker/freetds-1.00.27
RUN /bin/bash -c "/usr/src/slacker/freetds-1.00.27/configure --prefix=/usr/local --with-tdsver=7.3" 
RUN make && make install

WORKDIR /usr/src/slacker
RUN rbenv install 2.4.1
RUN rbenv global 2.4.1

RUN gem install tiny_tds -f 
RUN gem install slacker
