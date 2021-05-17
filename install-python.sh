#!/usr/bin/env bash
# References
# - https://github.com/pyenv/pyenv
# - https://github.com/pyenv/pyenv-installer
# - https://github.com/pyenv/pyenv/wiki#suggested-build-environment
# - https://github.com/momo-lab/xxenv-latest

set -o errexit
set -o pipefail

# Install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Configure .bashrc
{
    # shellcheck disable=SC2016
    printf '\nexport PATH="%s/.pyenv/bin:$PATH"\n' "${HOME}"
    # shellcheck disable=SC2016
    printf 'eval "$(pyenv init -)"\n'
    # shellcheck disable=SC2016
    printf 'eval "eval$(pyenv virtualenv-init -)"\n'
} >> "${HOME}/.bashrc"

# Configure .zshrc
{
    # shellcheck disable=SC2016
    printf '\nexport PATH="%s/.pyenv/bin:$PATH"\n' "${HOME}"
    # shellcheck disable=SC2016
    printf 'eval "$(pyenv init -)"\n'
    # shellcheck disable=SC2016
    printf 'eval "eval$(pyenv virtualenv-init -)"\n' 
} >> "${HOME}/.zshrc"

# Install build dependencies
sudo apt-get update; sudo apt-get install --yes --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Install xxenv-latest
git clone https://github.com/momo-lab/xxenv-latest.git "$(pyenv root)"/plugins/xxenv-latest

# Install the latest Python 3
pyenv latest install

# Set global python to the latest version
pyenv latest global
python --version
