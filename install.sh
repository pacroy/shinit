#!/bin/sh
INITDIR="$HOME/.init"

git --version
git clone --depth 1 https://github.com/pacroy/sh-init.git "$INITDIR"
chmod +x "$INITDIR/init.sh"
$INITDIR/init.sh
