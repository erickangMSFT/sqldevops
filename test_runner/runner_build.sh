dt=`date '+%Y-%m-%d_%H-%M-%S'`
echo $dt

docker build . --rm -t ericskang/slacker-node-runner:$dt

docker tag ericskang/slacker-node-runner:$dt ericskang/slacker-node-runner:latest
docker tag ericskang/slacker-node-runner:$dt sqldevopsacs.azurecr.io/slacker-node-runner:$dt
docker tag ericskang/slacker-node-runner:latest sqldevopsacs.azurecr.io/slacker-node-runner:latest

echo sqldevopsacs.azurecr.io/slacker-node-runner:$dt

#docker login

#docker push ericskang/slacker-node-runner:$dt
#docker push ericskang/slacker-node-runner:latest

#docker rm -f slacker-runner
docker rmi -f slacker-node-runner:temp

docker rmi -f $(docker images -f "dangling=true" -q)