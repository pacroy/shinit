#!/usr/bin/env bash
# Source: https://docs.openshift.com/container-platform/3.11/cli_reference/get_started_cli.html#cli-linux
set -o errexit
set -o pipefail

OC_VERSION="3.11.420-1"
OC_URL="https://mirror.openshift.com/pub/openshift-v3/clients/${OC_VERSION}/linux/oc.tar.gz"

OC4_VERSION="4.6.29"
OC4_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/${OC4_VERSION}/openshift-client-linux.tar.gz"

# Download oc3
curl -fL "${OC_URL}" -o "${HOME}/oc.tgz"
tar -C "${HOME}" -xzf "${HOME}/oc.tgz" oc

# Install oc3
sudo install -o root -g root -m 0755 "${HOME}/oc" /usr/local/bin/oc
sudo ln -s /usr/local/bin/oc /usr/local/bin/oc3
oc version

# Clean up oc3
rm "${HOME}/oc"
rm "${HOME}/oc.tgz"

# Download oc4
curl -fL "${OC4_URL}" -o "${HOME}/oc4.tgz"
tar -C "${HOME}" -xzf "${HOME}/oc4.tgz" oc

# Install oc4
sudo install -o root -g root -m 0755 "${HOME}/oc" /usr/local/bin/oc4
oc4 version

# Clean up
rm "${HOME}/oc"
rm "${HOME}/oc.tgz"

# Clean up oc4
rm "${HOME}/oc"
rm "${HOME}/oc4.tgz"
