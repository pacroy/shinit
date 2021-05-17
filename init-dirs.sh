#!/usr/bin/env bash
set -o errexit
set -o pipefail

if [ ! -d ~/dev ]; then
    echo "Creating directory ~/dev (if not exist) ..."
    mkdir -p ~/dev
fi
if [ ! -d ~/bin ]; then
    echo "Creating directory ~/bin (if not exist) ..."
    mkdir -p ~/bin;
fi 

username=$(whoami)
if [ ! -e ~/${username} ]; then
    echo "Creating symbolic link ~/${username} ..."
    usrdir_default="/mnt/c/Users/${username}/dev"
    read -rp "Home path on host [ENTER for ${usrdir_default}]:" usrdir_input </dev/tty
    usr_path=${usrdir_input:-${usrdir_default}}
    mkdir -p "~/${username}"
    ln -s "${usr_path}" "~/${username}"
fi
