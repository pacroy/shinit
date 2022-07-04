#!/usr/bin/env bash
set -o errexit
set -o pipefail

INITDIR="$HOME/.init"

if [ -d "${INITDIR}" ]; then
    (   
        cd "${INITDIR}"
        git reset --quiet --hard main
        git pull --quiet
        if git submodule status; then
            git submodule --quite deinit --force --all
        fi
        git submodule --quite init
        git submodule update
    )
else
    git clone --quiet --depth 1 https://github.com/pacroy/sh-init.git "${INITDIR}"
    {
        cd "${INITDIR}"
        git submodule init
        git submodule update
    }
fi

"${INITDIR}/install2.sh" "${INITDIR}"
