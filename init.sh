#!/usr/bin/env bash
set -o errexit
set -o pipefail

# shellcheck disable=SC2034
INITDIR="${HOME}/.init"
# shellcheck disable=SC1091
source "${INITDIR}/aliases.sh"
PATH="${PATH}:${HOME}/bin"
unset LESS
