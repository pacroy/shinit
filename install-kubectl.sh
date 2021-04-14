#!/bin/sh
# References:
# - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

set -o errexit
set -o pipefail

# Download the latest version
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client