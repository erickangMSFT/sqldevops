docker build . --rm -t tools:temp

docker run --name tools_temp -d tools:temp
docker export tools_temp | docker import - tools:latest

docker rm -f tools_temp
docker rmi tools:temp

docker rmi -f $(docker images -f "dangling=true" -q)