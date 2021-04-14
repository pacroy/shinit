#!/usr/bin/env bash
# References:
# - https://helm.sh/docs/intro/install/   

set -o errexit
set -o pipefail

# Download and install
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm version
