# az login
# az account set -s 'your subscription if you have more than one'

az provider register -n Microsoft.ContainerService
az provider register -n Microsoft.Compute
az provider register -n Microsoft.Network

az group create -n mvademok8sgroup -l westus2

az aks create -g mvademok8sgroup \
    -n mvademok8scluster \
    --node-count 1 \
    --node-vm-size Standard_D2s_v3 \
    --generate-ssh-keys

# az aks scale \ 
#     -g mvademok8sgroup \
#     -n mvademok8scluster \
#     --node-count 5 \

az aks install-cli

az aks get-credentials \
    -g mvademok8sgroup \
    -n mvademok8scluster
    
kubectl config get-contexts

clear
kubectl cluster-info