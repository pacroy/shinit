#!/usr/bin/env bash
# References:
# - https://github.com/Azure/kubelogin

set -o errexit
set -o pipefail

KUBELOGIN_VERSION="0.0.9"

# Check unzip
if ! which unzip; then
    sudo apt install -y unzip
fi

# Download the latest version
curl -L "https://github.com/Azure/kubelogin/releases/download/v${KUBELOGIN_VERSION}/kubelogin-linux-amd64.zip" -o "${HOME}/kubelogin.zip"
unzip -j "${HOME}/kubelogin.zip" bin/linux_amd64/kubelogin -d "${HOME}"

# Install
sudo install -o root -g root -m 0755 "${HOME}/kubelogin" /usr/local/bin/kubelogin
kubelogin --version

# Clean up
rm "${HOME}/kubelogin"
rm "${HOME}/kubelogin.zip"
