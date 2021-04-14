#!/bin/sh
set -e

if [ ! -d ~/.ssh ] || ! ls ~/.ssh/id* > /dev/null; then
    echo "Generate a new SSH keypair..."
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""

    echo "Adding the new SSH keypair to SSH agent..."
    eval `ssh-agent -s`
    ssh-add ~/.ssh/id_ed25519
fi
