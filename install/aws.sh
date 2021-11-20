#!/usr/bin/env bash
# References:
# - https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install

set -o errexit
set -o pipefail

# Check and install required softwares
softwares=""
which unzip > /dev/null || softwares+="unzip "
if [ -n "$softwares" ]; then
    sudo apt update
    # shellcheck disable=SC2086
    sudo apt install -y $softwares
fi

# Check input variables
if [ -z "${AWS_VERSION}" ]; then
	echo "AWS_VERSION is not specified. Will download the latest version."
	download_url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
else
	download_url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_VERSION}.zip"
fi

# Download
readonly temp_dir="${HOME}/.installtmp"
mkdir -p "${temp_dir}"
echo "Downloading from ${download_url} ..."
curl -fL "${download_url}" -o "${temp_dir}/awscli2.zip"
unzip "${temp_dir}/awscli2.zip" -d "${temp_dir}"

# Install
mkdir -p "${HOME}/bin"
"${temp_dir}/aws/install" --install-dir "${HOME}/.aws-cli" --bin-dir "${HOME}/bin"
"${HOME}/bin/aws" --version

# Set PATH
if ! which aws; then
  echo >&2 "WARNING: Please add '${HOME}/bin' to your PATH environment variable."
fi

# Clean up
rm -rf "${temp_dir}"
