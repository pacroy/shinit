#!/usr/bin/env bash
set -o errexit
set -o pipefail

INITDIR="${1}"
if [ -z "${INITDIR}" ]; then echo 'INITDIR is not specified' >&2 && exit 1; fi

INITSH="$INITDIR/init.sh"

# Configure .bashrc or .bash_profile
if [ -f "${HOME}/.bashrc" ]; then
    if ! grep -F "source ${INITSH}" "${HOME}/.bashrc" > /dev/null; then
        printf "\nsource ${INITSH}" >> "${HOME}/.bashrc"
    fi
elif [ -f "${HOME}/.bash_profile" ]; then
    if ! grep -F "source ${INITSH}" "${HOME}/.bash_profile" > /dev/null; then
        printf "\nsource ${INITSH}" >> "${HOME}/.bash_profile"
    fi
fi

# Configure .zshrc
if [ -f "${HOME}/.zshrc" ]; then
    if ! grep -F "source ${INITSH}" "${HOME}/.zshrc" > /dev/null; then
        printf "\nsource ${INITSH}" >> "${HOME}/.zshrc"
    fi
fi
