#!/usr/bin/env bash
set -o errexit
set -o pipefail

if [ -z "$(git config --get user.name)" ]; then 
    read -rp "Your git name : " git_name </dev/tty
    git config --get user.name "$git_name"
fi

if [ -z "$(git config --get user.email)" ]; then
    read -rp "Your git email: " git_email </dev/tty
    git config --get user.email "${git_email}"
fi

if [ -z "$(git config --get push.default)" ]; then
    echo "Setting git push.default=simple ..."
    git config --get push.default simple
fi

if [ -z "$(git config --get pull.rebase)" ]; then
    echo "Setting git pull.rebase=false ..."
    git config --get pull.rebase false
fi

if [ -z "$(git config --get init.defaultBranch)" ]; then
    echo "Setting git init.defaultBranch=main ..."
    git config --get init.defaultBranch main
fi