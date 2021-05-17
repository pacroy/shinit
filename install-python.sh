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

# Configure bash
{
    printf 'export PYENV_ROOT="$HOME/.pyenv"\n'
    printf 'export PATH="$PYENV_ROOT/bin:$PATH"\n'
    printf 'eval "$(pyenv init --path)"\n\n'
} | cat - "${HOME}/.profile" > "/tmp/.profile" && mv "/tmp/.profile" "${HOME}/.profile"
{
    printf '\neval "$(pyenv init -)"\n'
} >> "${HOME}/.bashrc"

# Configure zsh
{
    printf '\nexport PYENV_ROOT="$HOME/.pyenv"\n'
    printf 'export PATH="$PYENV_ROOT/bin:$PATH"\n'
    printf 'eval "$(pyenv init --path)"\n'
} >> "${HOME}/.zprofile"
{
    printf '\neval "$(pyenv init -)"\n'
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
