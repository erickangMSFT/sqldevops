az provider register -n Microsoft.ContainerService
az provider register -n Microsoft.Compute
az provider register -n Microsoft.Network

az group create -n myaksgroup -l westus2

az aks create -g myaksgroup \
    -n myk8s \
    --agent-count 1 \
    --agent-vm-size Standard_D2s_v3 \
    --generate-ssh-keys

az aks install-cli

az aks get-credentials \
    -g myaksgroup \
    -n myk8s

kubectl config get-contexts