#!/usr/bin/env bash
# Source: https://stedolan.github.io/jq/download/
set -o errexit
set -o pipefail

JQ_VERSION="1.6"

# Download
curl -fL "https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64" -o "${HOME}/jq"

# Install
sudo install -o root -g root -m 0755 "${HOME}/jq" /usr/local/bin/oc
jq --version

# Clean up
rm "${HOME}/jq"
