#!/usr/bin/env bash
# References:
# - https://www.terraform.io/downloads.html

set -o errexit
set -o pipefail

TERRAFORM_VERSION="0.15.1"

# Check unzip
if ! which unzip; then
    sudo apt install -y unzip
fi

# Download
curl -fL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o "${HOME}/terraform.zip"
unzip -j "${HOME}/terraform.zip" terraform -d "${HOME}"

# Install
sudo install -o root -g root -m 0755 "${HOME}/terraform" /usr/local/bin/terraform
terraform version

# Clean up
rm "${HOME}/terraform"
rm "${HOME}/terraform.zip"
