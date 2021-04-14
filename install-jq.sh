#!/bin/sh
# Source: https://stedolan.github.io/jq/download/
set -e

curl -fL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o $HOME/bin/jq
chmod +x $HOME/bin/jq
jq --version
