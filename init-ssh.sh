#!/usr/bin/env bash
set -o errexit
set -o pipefail

if [ ! -d ~/.ssh ] || ! ls ~/.ssh/id* &>/dev/null; then
    echo "Generate a new SSH keypair..."
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""

    echo "Adding the new SSH keypair to SSH agent..."
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
fi
