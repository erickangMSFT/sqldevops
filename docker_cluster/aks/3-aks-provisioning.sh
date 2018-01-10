# az login
# az account set -s 'your subscription if you have more than one'

az provider register -n Microsoft.ContainerService
az provider register -n Microsoft.Compute
az provider register -n Microsoft.Network

az group create -n mvademoaksgroup -l westus2

az aks create -g mvademoaksgroup \
    -n mvademok8s \
    --node-count 3 \
    --node-vm-size Standard_D2s_v3 \
    --generate-ssh-keys


az aks install-cli

az aks get-credentials \
    -g mvademoaksgroup \
    -n mvademok8s
kubectl config get-contexts

clear
kubectl cluster-info