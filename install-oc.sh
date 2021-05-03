#!/usr/bin/env bash
# Source: https://docs.openshift.com/container-platform/3.11/cli_reference/get_started_cli.html#cli-linux
set -o errexit
set -o pipefail

OC_VERSION="3.11.420-1"
OC_URL="https://mirror.openshift.com/pub/openshift-v3/clients/${OC_VERSION}/linux/oc.tar.gz"

# Download
curl -fL "${OC_URL}" -o "${HOME}/oc.tgz"
tar -C "${HOME}" -xzf "${HOME}/oc.tgz" oc

# Install
sudo install -o root -g root -m 0755 "${HOME}/oc" /usr/local/bin/oc
oc version

# Clean up
rm "${HOME}/oc"
rm "${HOME}/oc.tgz"
