#!/bin/sh

if [ ! -d ~/dev ]; then 
    if [ -z $WSLENV ]; then
        echo "Creating directory ~/dev ..."
        mkdir ~/dev
    else
        DEVDIR="/mnt/c/Users/$(whoami)/dev"
        read -p "dev path [ENTER for $DEVDIR]:" devdir_input </dev/tty
        dev_path=${DEVDIR_INPUT:-$DEVDIR}
        if [ ! -d $dev_path ]; then mkdir $dev_path; fi
        ln -s $dev_path ~/dev
    fi
fi

if [ ! -d ~/bin ]; then 
    echo "Creating directory ~/bin ..."
    mkdir ~/bin; 
fi
