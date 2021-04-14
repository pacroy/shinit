#!/usr/bin/env bash
# References:
# - https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt

set -o errexit
set -o pipefail

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az version
