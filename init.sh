#!/usr/bin/env bash
set -o errexit
set -o pipefail

INITDIR="${HOME}/.init"
source "${HOME}/.init/aliases.sh"
PATH="${PATH}:${HOME}/bin"
unset LESS
