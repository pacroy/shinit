#!/usr/bin/env bash
set -o errexit
set -o pipefail

# Install zsh
sudo apt install -y zsh

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set theme to agnoster
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
if ! grep -qF "DEFAULT_USER=$USER" ~/.zshrc; then
    echo "DEFAULT_USER=$USER" >> ~/.zshrc
fi
if ! grep -qF "source ~/.init/init.sh" ~/.zshrc; then
    echo "source ~/.init/init.sh" >> ~/.zshrc
fi

# shellcheck disable=SC1091
source "${HOME}/.zshrc"
