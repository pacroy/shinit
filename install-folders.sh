#!/bin/sh

if [ ! -d ~/dev ]; then 
    if [ -z $WSLENV ]; then
        mkdir ~/dev
    else
        DEVDIR="/mnt/c/Users/$(whoami)/dev"
        read -p "Input your dev path [$DEVDIR]:" DEVDIR_INPUT
        DEVDIR=${DEVDIR_INPUT:-$DEVDIR}
        ln -s $dev_path ~/dev
    fi
fi
if [ ! -d ~/bin ]; then mkdir ~/bin; fi
