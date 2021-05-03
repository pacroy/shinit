#!/usr/bin/env bash
set -o errexit
set -o pipefail

INITDIR="$HOME/.init"

if [ -d "${INITDIR}" ]; then
    (   
        cd "${INITDIR}"
        git reset --quiet --hard main
        git pull --quiet 
    )
else
    git clone --quiet --depth 1 https://github.com/pacroy/sh-init.git "${INITDIR}"
fi

"${INITDIR}/install2.sh" "${INITDIR}"
