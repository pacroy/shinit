#!/usr/bin/env bash
set -o errexit
set -o pipefail

DEFAULT_INITDIR="$HOME/.init"
export INITDIR="${INITDIR:-$DEFAULT_INITDIR}"

if [ -d "${INITDIR}" ]; then
    (   
        cd "${INITDIR}"
        git reset --quiet --hard main
        git pull --quiet
        if git submodule status; then
            git submodule --quiet deinit --force --all
        fi
        git submodule --quiet init
        git submodule update
    )
else
    git clone --quiet --depth 1 https://github.com/pacroy/shinit.git "${INITDIR}"
    {
        cd "${INITDIR}"
        git submodule init
        git submodule update
    }
fi

"${INITDIR}/install2.sh" "${INITDIR}"
