#!/bin/sh
set -e

INITDIR="$HOME/.init"

git --version
if [ -d "$INITDIR" ]; then
    CURRENTDIR=$(pwd)
    cd "$INITDIR"
    git reset --hard main
    git pull
    cd $CURRENTDIR
    unset CURRENTDIR
else
    git clone --depth 1 https://github.com/pacroy/sh-init.git "$INITDIR"
fi
chmod +x $INITDIR/*.sh
$INITDIR/install-init.sh
