#!/usr/bin/env bash
# Source: https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10
set -o errexit
set -o pipefail

RELEASE_DATE="20210415"
AZCOPY_VERSION="10.10.0"

# Download
curl -fL "https://azcopyvnext.azureedge.net/release${RELEASE_DATE}/azcopy_linux_amd64_${AZCOPY_VERSION}.tar.gz" -o "${HOME}/azcopy.tar.gz"
tar -xzf "${HOME}/azcopy.tar.gz"

# Install
sudo install -o root -g root -m 0755 "${HOME}/azcopy_linux_amd64_${AZCOPY_VERSION}/azcopy" /usr/local/bin/azcopy
azcopy --version

# Clean up
rm -rf "${HOME}/azcopy_linux_amd64_${AZCOPY_VERSION}"
rm -f "${HOME}/azcopy.tar.gz"
