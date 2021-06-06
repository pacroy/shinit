# Linux Shell Initialization Scripts

[![Lint Code Base](https://github.com/pacroy/sh-init/actions/workflows/linter.yml/badge.svg)](https://github.com/pacroy/sh-init/actions/workflows/linter.yml) [![Check Markdown links](https://github.com/pacroy/sh-init/actions/workflows/check-md-links.yml/badge.svg)](https://github.com/pacroy/sh-init/actions/workflows/check-md-links.yml)

Linux Shell Initialization Scripts

## Install

Usual installation

```bash
curl -fsSL https://par.sh/sh-init | bash && source $HOME/.init/init.sh
```

Installation behind proxy

```bash
curl -fsSL https://raw.githubusercontent.com/pacroy/sh-init/main/install.sh -x "$proxy" | bash && source $HOME/.init/init.sh
```