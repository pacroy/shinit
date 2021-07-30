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
	readonly version_url="https://api.github.com/repos/hashicorp/terraform/releases/latest"
	echo "TERRAFORM_VERSION is not specified. Getting the latest version from ${version_url} ..."
	terraform_latest_tag=$(curl -fsSL ${version_url} | jq -r ".tag_name")
	terraform_latest_version=${terraform_latest_tag#"v"}
	TERRAFORM_VERSION="$terraform_latest_version"
fi

# Download
readonly install_dir="${HOME}/.install"
mkdir -p "${install_dir}"
download_url="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" 
echo "Downloading from ${download_url} ..."
curl -fL "${download_url}" -o "${install_dir}/terraform.zip"
unzip -j "${install_dir}/terraform.zip" terraform -d "${install_dir}"

# Install
mkdir -p "${HOME}/bin"
install -o "${USER}" -g "$USER" -m 0755 "${install_dir}/terraform" "${HOME}/bin/terraform"
terraform version

# Clean up
rm -rf "${install_dir}"
