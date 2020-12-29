#!/bin/sh
set -e

INITDIR="$1"
if [ -z $INITDIR ]; then echo 'INITDIR is not specified' >&2 && exit 1; fi

$INITDIR/install-folders.sh $@
$INITDIR/install-init.sh $@
