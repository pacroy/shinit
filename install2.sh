#!/usr/bin/env bash
set -o errexit
set -o pipefail

INITDIR="${1}"
if [ -z "${INITDIR}" ]; then echo 'INITDIR is not specified' >&2 && exit 1; fi

"${INITDIR}/init-dirs.sh" "$@"
"${INITDIR}/init-ssh.sh" "$@"
"${INITDIR}/init-git.sh" "$@"

"${INITDIR}/init-rc.sh" "$@"

echo "Installation completed"
