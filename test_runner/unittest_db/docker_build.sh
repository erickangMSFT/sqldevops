docker build . --rm -t unittestdb:temp

docker run --name unittest -d unittestdb:temp
docker export unittest | docker import - tools:latest

docker rm -f tools_temp
docker rmi tools:temp

docker rmi -f $(docker images -f "dangling=true" -q)