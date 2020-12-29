#!/bin/sh
set -e

INITDIR="$HOME/.init"
INITSH="$INITDIR/init.sh"
ALIASES="$INITDIR/aliases.sh"
BINDIR="$HOME/bin"

echo '#!/bin/sh' > "$INITSH"

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

# Configure .zshrc
if [ -f "$HOME/.zshrc" ]; then
    if ! cat $HOME/.zshrc | grep "source $INITSH" > /dev/null; then
        echo "\nsource $INITSH" >> $HOME/.zshrc
    fi
fi

# Source init script
source $INITSH