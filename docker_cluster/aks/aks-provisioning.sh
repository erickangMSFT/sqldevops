#!/bin/bash
#az provider register -n Microsoft.ContainerService

az group create -n erickang-aks -l westus2

az aks create -g erickang-aks -n erickang-kluster --agent-count 1 --generate-ssh-keys

az aks install-cli

az aks get-credentials --resource-group erickang-aks --name erickang-kluster

az aks scale -g erickang-aks -n erickang-kluster -c 3