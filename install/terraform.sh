#!/usr/bin/env bash
# References:
# - https://www.terraform.io/downloads.html

set -o errexit
set -o pipefail

# Check and install required softwares
softwares=""
which unzip > /dev/null || softwares+="unzip "
which jq > /dev/null || softwares+="jq "
if [ -n "$softwares" ]; then
    sudo apt update
    sudo apt install -y "$softwares"
fi

# Check input variables
if [ -z "${TERRAFORM_VERSION}" ]; then
	terraform_latest_tag=$(curl -fsSL https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r ".tag_name")
	terraform_latest_version=${terraform_latest_tag#"v"}
	TERRAFORM_VERSION="$terraform_latest_version"
fi

# Download
url="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" 
echo "Downloading from $url ..."
curl -fL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o "${HOME}/terraform.zip"
unzip -j "${HOME}/terraform.zip" terraform -d "${HOME}"

# Install
sudo install -o root -g root -m 0755 "${HOME}/terraform" /usr/local/bin/terraform
terraform version

# Clean up
rm "${HOME}/terraform"
rm "${HOME}/terraform.zip"

