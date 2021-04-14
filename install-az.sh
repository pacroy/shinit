#!/usr/bin/env bash
# References:
# - https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt

set -o errexit
set -o pipefail

command -v apt > /dev/null || { >&2 echo "apt not found" && exit 90 }

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az version
