#!/usr/bin/env bash
set -o errexit
set -o pipefail

if [ ! -d ~/dev ]; then 
    if [ -z "${WSLENV}" ]; then
        echo "Creating directory ~/dev ..."
        mkdir ~/dev
    else
        devdir_default="/mnt/c/Users/$(whoami)/dev"
        read -rp "dev path [ENTER for ${devdir_default}]:" devdir_input </dev/tty
        dev_path=${devdir_input:-${devdir_default}}
        mkdir -p $dev_path
        ln -s "${dev_path}" ~/dev
    fi
fi

if [ ! -d ~/bin ]; then 
    echo "Creating directory ~/bin ..."
    mkdir ~/bin; 
fi
