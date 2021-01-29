#!/bin/sh
# Source: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
set -e

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az version
sudo az aks install-cli
kubectl version --client
