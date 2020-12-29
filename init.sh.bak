#!/bin/bash
set -e

# Determine environment type
if [ -z "$BASH_INIT_ENV_TYPE" ]; then
    if [[ $AZURE_HTTP_USER_AGENT =~ cloud-shell.* ]]; then
        BASH_INIT_ENV_TYPE="cloudshell"
    elif [ ! -z ${WSLENV+x} ]; then
        BASH_INIT_ENV_TYPE="wsl"
    else
        BASH_INIT_ENV_TYPE="generic"
    fi
fi
echo "Initializing for $BASH_INIT_ENV_TYPE..."

echo "Setting up directories..."
if [ ! -e ~/dev ]; then 
    if [ $BASH_INIT_ENV_TYPE == "wsl" ]; then
        read -p "Input your dev path [/mnt/c/Users/$(whoami)/dev]:" dev_path
        dev_path=${dev_path:-"/mnt/c/Users/$(whoami)/dev"}
        ln -s $dev_path ~/dev
    else
        mkdir ~/dev
    fi
fi
if [ ! -e ~/bin ]; then mkdir ~/bin; fi

if [ ! -d ~/.ssh ] || [ ! -e ~/.ssh/id_rsa ] || [ ! -e ~/.ssh/id_rsa.pub ]; then
    echo "Generate SSH keypair..."
    if [ ! -d ~/.ssh ]; then mkdir ~/.ssh; fi
    if [ $BASH_INIT_ENV_TYPE == "cloudshell" ]; then 
        hostid="cloudshell.$(az account show --query "tenantId" --output tsv)"
    elif [ $BASH_INIT_ENV_TYPE == "wsl" ]; then 
        hostid="wsl.$(hostname)"
    else 
        hostid="$(hostname)"
    fi
    ssh-keygen -t rsa -b 4096 -C "$(whoami)@$hostid" -f ~/.ssh/id_rsa -N ""
fi

echo "Setting git config..."
if [ -z "$(git config --global user.name)" ]; then 
    read -p "Your git name [$(whoami)]: " git_name </dev/tty
    git_name=${git_name:-$(whoami)}
    git config --global user.name "$git_name"
fi
if [ -z "$(git config --global user.email)" ]; then
    if [ $BASH_INIT_ENV_TYPE == "cloudshell" ]; then 
        cloudshell_email=$(az account show --query "user.name" --output tsv)
        read -p "Your git email [$cloudshell_email]: " git_email </dev/tty
        git_email=${git_email:-$cloudshell_email}
    else
        while [ -z "$git_email" ]; do read -p "Your git email: " git_email </dev/tty; done
    fi
    git config --global user.email $git_email
fi
if [ -z "$(git config --global push.default)" ]; then
    git config --global push.default simple
fi
if [ -z "$(git config --global pull.rebase)" ]; then
    git config --global pull.rebase false
fi

alias_url=http://par.sh/alias
if [ -f ~/alias.sh ]; then
    echo "Updating alias..."    
    curl -sSL $alias_url -o ~/alias.sh
else
    echo "Installing alias..."
    curl -sSL $alias_url -o ~/alias.sh
    echo -en "\nsource ~/alias.sh\n" >> ~/.bashrc
fi

echo "Initialization completed"

echo ""
echo "===== Git configurations ====="
git --version
git config --global --list
echo "===== Your SSH Public Key ====="
cat ~/.ssh/id_rsa.pub
echo "==============================="
