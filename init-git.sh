#!/bin/sh
set -e

if [ -z "$(git config --global user.name)" ]; then 
    read -p "Your git name : " git_name </dev/tty
    git config --global user.name "$git_name"
fi

if [ -z "$(git config --global user.email)" ]; then
    read -p "Your git email: " git_email </dev/tty
    git config --global user.email $git_email
fi

if [ -z "$(git config --global push.default)" ]; then
    echo "Setting git push.default=simple ..."
    git config --global push.default simple
fi

if [ -z "$(git config --global pull.rebase)" ]; then
    echo "Setting git pull.rebase=false ..."
    git config --global pull.rebase false
fi

if [ -z "$(git config --global init.defaultBranch)" ]; then
    echo "Setting git init.defaultBranch=main ..."
    git config --global init.defaultBranch main
fi