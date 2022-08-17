#!/usr/bin/env bash
set -o errexit
set -o pipefail

if [ ! -d ~/.ssh ] || ! ls ~/.ssh/id* &>/dev/null; then
    read -rp "SSH key is not found. Generate and configure a new one? (yes to proceed): " is_generate_ssh </dev/tty
    if [ "${is_generate_ssh}" = "yes" ]; then
        echo "Generate a new SSH keypair..."
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""

        echo "Adding the new SSH keypair to SSH agent..."
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_rsa
    fi
fi
