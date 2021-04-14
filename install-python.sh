#!/bin/sh
# References
# - https://github.com/pyenv/pyenv
# - https://github.com/pyenv/pyenv-installer
# - https://github.com/pyenv/pyenv/wiki#suggested-build-environment
# - https://github.com/momo-lab/xxenv-latest

set -o errexit
set -o pipefail

# Install pyenv
curl https://pyenv.run | bash

# Configure .bashrc
printf '\nexport PATH="/home/pacroy/.pyenv/bin:$PATH"\n' >> $HOME/.bashrc
printf 'eval "$(pyenv init -)"\n' >> $HOME/.bashrc
printf 'eval "eval$(pyenv virtualenv-init -)"\n' >> $HOME/.bashrc

# Configure .zshrc
printf '\nexport PATH="/home/pacroy/.pyenv/bin:$PATH"\n' >> $HOME/.zshrc
printf 'eval "$(pyenv init -)"\n' >> $HOME/.zshrc
printf 'eval "eval$(pyenv virtualenv-init -)"\n' >> $HOME/.zshrc

# Install build dependencies
sudo apt-get update; sudo apt-get install --yes --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Install xxenv-latest
git clone https://github.com/momo-lab/xxenv-latest.git "$(pyenv root)"/plugins/xxenv-latest

# Install the latest Python 3
pyenv latest install

# Set global python to the latest version
pyenv latest global
python --version
