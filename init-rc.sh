#!/bin/sh
set -e

INITDIR="$1"
if [ -z $INITDIR ]; then echo 'INITDIR is not specified' >&2 && exit 1; fi

INITSH="$INITDIR/init.sh"

# Configure .bashrc or .bash_profile
if [ -f "$HOME/.bashrc" ]; then
    if ! cat $HOME/.bashrc | grep "source $INITSH" > /dev/null; then
        echo "\nsource $INITSH" >> $HOME/.bashrc
    fi
elif [ -f "$HOME/.bash_profile" ]; then
    if ! cat $HOME/.bash_profile | grep "source $INITSH" > /dev/null; then
        echo "\nsource $INITSH" >> $HOME/.bash_profile
    fi
fi

# Configure .zshrc
if [ -f "$HOME/.zshrc" ]; then
    if ! cat $HOME/.zshrc | grep "source $INITSH" > /dev/null; then
        echo "\nsource $INITSH" >> $HOME/.zshrc
    fi
fi
