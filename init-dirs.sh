#!/usr/bin/env bash
set -o errexit
set -o pipefail

echo "Creating directory ~/dev (if not exist) ..."
mkdir -p ~/dev
echo "Creating directory ~/bin (if not exist) ..."
mkdir -p ~/bin; 

username=$(whoami)
echo "Creating symbolic link ~/${username} ..."
usrdir_default="/mnt/c/Users/${username}/dev"
read -rp "Home path on host [ENTER for ${usrdir_default}]:" usrdir_input </dev/tty
usr_path=${usrdir_input:-${usrdir_default}}
ln -s "${usr_path}" "~/${username}"
