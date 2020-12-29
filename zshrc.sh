#!/bin/sh

ZSHRC="$HOME/zshrc.sh"
ALIASES="$HOME/aliases.sh"
BIN="$HOME/bin"

echo '#!/bin/zsh' > "$ZSHRC"

# Add aliases
if [ -f "$ALIASES" ]; then
    echo "source $ALIASES" >> "$ZSHRC"
fi

# Add bin directory to PATH
if [ -d "$BIN" ]; then
    echo 'PATH=$PATH:'"$BIN" >> "$ZSHRC"
fi

# Configure less behavior
echo 'unset LESS' >> "$ZSHRC"

# Configure .zshrc
if ! cat $HOME/.zshrc | grep 'source ~/zshrc.sh' > /dev/null; then
    echo '\nsource ~/zshrc.sh' >> $HOME/.zshrc
fi