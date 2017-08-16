#!/bin/bash

rm -rf docker/git
mkdir docker/git
git clone https://github.com/rbenv/rbenv.git ./docker/git/rbenv 
git clone https://github.com/rbenv/ruby-build.git ./docker/git/rbenv/plugins/ruby-build 

cd docker/git 

curl ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.27.tar.gz -o freetds-1.00.27.tar.gz && tar -xzf freetds-1.00.27.tar.gz 
rm freetds-1.00.27.tar.gz
cd ../..

docker build . --rm -t slackerbuild:latest

docker rmi -f $(docker images -f "dangling=true" -q)