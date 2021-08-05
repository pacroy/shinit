#!/usr/bin/env bash
# References:
# - https://github.com/Azure/kubelogin

set -o errexit
set -o pipefail

# Check and install required softwares
softwares=""
which unzip > /dev/null || softwares+="unzip "
if [ -n "$softwares" ]; then
    sudo apt update
    sudo apt install -y $softwares
fi

# Check version
if [ -z "${KUBELOGIN_VERSION}" ]; then
    readonly version_url="https://api.github.com/repos/Azure/kubelogin/releases/latest"
    kubelogin_latest_tag=$(curl -fsSL ${version_url} | jq -r ".tag_name")
    kubelogin_latest_version=${kubelogin_latest_tag#"v"}
	echo "KUBELOGIN_VERSION is not specified. Will download the latest version $kubelogin_latest_version."
	KUBELOGIN_VERSION="$kubelogin_latest_version"
fi

# Download
readonly temp_dir="${HOME}/.installtmp"
mkdir -p "${temp_dir}"
echo "Downloading from ${download_url} ..."
download_url="https://github.com/Azure/kubelogin/releases/download/v${KUBELOGIN_VERSION}/kubelogin-linux-amd64.zip" 
curl -fL "${download_url}" -o "${temp_dir}/kubelogin.zip"
unzip -j "${temp_dir}/kubelogin.zip" bin/linux_amd64/kubelogin -d "${temp_dir}"

# Install
mkdir -p "${HOME}/bin"
install -o "${USER}" -g "$USER" -m 0755 "${temp_dir}/kubelogin" "${HOME}/bin/kubelogin"
"${HOME}/bin/kubelogin" --version

# Set PATH
if ! which kubelogin; then
  echo >&2 "WARNING: Please add '${HOME}/bin' to your PATH environment variable."
fi

# Clean up
rm -rf "${temp_dir}"
