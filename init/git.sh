#!/usr/bin/env bash
set -o errexit
set -o pipefail

if [ -z "$(git config --get user.name)" ]; then 
    read -rp "Your name : " git_name </dev/tty
    echo "Configuring git user.name=${git_name} ..."
    git config --get user.name "$git_name"
fi

if [ -z "$(git config --get user.email)" ]; then
    read -rp "Your GitHub username: " github_username </dev/tty
    git_email="${github_username@users.noreply.github.com"
    echo "Configuring git user.email=${git_email} ..."
    git config --get user.email "${git_email}"
fi

if [ -z "$(git config --get init.defaultBranch)" ]; then
    echo "Configuring git init.defaultBranch=main ..."
    git config --get init.defaultBranch main
fi