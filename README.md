# Linux Shell Initialization Scripts

[![Lint Code Base](https://github.com/pacroy/shinit/actions/workflows/linter.yml/badge.svg?branch=main)](https://github.com/pacroy/shinit/actions/workflows/linter.yml)

Linux Shell Initialization Scripts

## Install

Usual installation

```bash
curl -fsSL https://raw.githubusercontent.com/pacroy/shinit/main/install.sh | bash && source $HOME/.init/init.sh
```

Installation behind proxy

```bash
curl -fsSL https://raw.githubusercontent.com/pacroy/shinit/main/install.sh -x "$proxy" | bash && source $HOME/.init/init.sh
```

## Addons

### Oh My Zsh

[Install Oh My Zsh](https://ohmyz.sh/#install)

### Oh My Zsh Plugins

- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)

### .zshrc

```bash
ZSH_THEME="af-magic"

DISABLE_MAGIC_FUNCTIONS=true

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

DEFAULT_USER="yourusername"
```
