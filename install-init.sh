#!/bin/sh
set -e

INITDIR="$1"
if [ -z $INITDIR ]; then echo 'INITDIR is not specified' >&2 && exit 1; fi

INITSH="$INITDIR/init.sh"
ALIASES="$INITDIR/aliases.sh"
BINDIR="$HOME/bin"

echo '#!/bin/sh' > "$INITSH"
echo 'INITDIR="$HOME/.init"' > "$INITSH"

# Add aliases
if [ -f "$ALIASES" ]; then
    echo "source $ALIASES" >> "$INITSH"
fi

# Add bin directory to PATH
if [ -d "$BINDIR" ]; then
    echo 'PATH=$PATH:'"$BINDIR" >> "$INITSH"
fi

# Configure less behavior
echo 'unset LESS' >> "$INITSH"

# Configure .bashrc or .bash_profile
if [ -f "$HOME/.bashrc" ]; then
    if ! cat $HOME/.bashrc | grep "source $INITSH" > /dev/null; then
        echo "\nsource $INITSH" >> $HOME/.bashrc
    fi
elif [ -f "$HOME/.bash_profile" ]; then
    if ! cat $HOME/.bash_profile | grep "source $INITSH" > /dev/null; then
        echo "\nsource $INITSH" >> $HOME/.bash_profile
    fi
fi

# Configure .zshrc
if [ -f "$HOME/.zshrc" ]; then
    if ! cat $HOME/.zshrc | grep "source $INITSH" > /dev/null; then
        echo "\nsource $INITSH" >> $HOME/.zshrc
    fi
fi
