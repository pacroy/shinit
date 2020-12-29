#!/bin/sh
set -e

echo "Configure git..."
if [ -z "$(git config --global user.name)" ]; then 
    read -p "Your name : " git_name </dev/tty
    git config --global user.name "$git_name"
fi

if [ -z "$(git config --global user.email)" ]; then
    read -p "Your email: " git_email </dev/tty
    git config --global user.email $git_email
fi

if [ -z "$(git config --global push.default)" ]; then
    git config --global push.default simple
fi

if [ -z "$(git config --global pull.rebase)" ]; then
    git config --global pull.rebase false
fi
