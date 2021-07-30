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
    sudo apt install -y $softwares
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
readonly temp_dir="${HOME}/.installtmp"
mkdir -p "${temp_dir}"
download_url="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" 
echo "Downloading from ${download_url} ..."
curl -fL "${download_url}" -o "${temp_dir}/terraform.zip"
unzip -j "${temp_dir}/terraform.zip" terraform -d "${temp_dir}"

# Install
mkdir -p "${HOME}/bin"
install -o "${USER}" -g "$USER" -m 0755 "${temp_dir}/terraform" "${HOME}/bin/terraform"
"${HOME}/bin/terraform" version

# Set PATH
if ! which terraform; then
  echo >&2 "WARNING: Please add '${HOME}/bin' to your PATH environment variable."
fi

# Clean up
rm -rf "${temp_dir}"
