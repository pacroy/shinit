#!/usr/bin/env bash
set -o errexit
set -o pipefail

if [ -z "$(git config --get user.name)" ]; then 
    read -rp "Your name : " git_name </dev/tty
    echo "Configuring git user.name=${git_name} ..."
    git config --global user.name "$git_name"
fi

if [ -z "$(git config --get user.email)" ]; then
    read -rp "Your GitHub username: " github_username </dev/tty
    git_email="${github_username}@users.noreply.github.com"
    echo "Configuring git user.email=${git_email} ..."
    git config --global user.email "${git_email}"
fi

if [ -z "$(git config --get init.defaultBranch)" ]; then
    echo "Configuring git init.defaultBranch=main ..."
    git config --global init.defaultBranch main
fi

if [ -z "$(git config --get user.signingkey)" ] && [ -z "${SHINIT_SKIP_GPG}" ]; then
    read -rp "GPG key is not configured. Generate and configure a new one? (yes to proceed): " is_generate_gpg </dev/tty
    if [ "${is_generate_gpg}" = "yes" ]; then
        echo "A new GPG will be generated to sign your git commits. Please choose the following options when asked:"
        echo "   kind of key = RSA and RSA"
        echo "   keysize = 4096"
        echo "   how long the key should be valid = <as you want e.g. 1y>"
        echo "   Real name = Your full name"
        echo "   Email address = <github_username>@users.noreply.github.com"
        echo "   Comment = <as you want e.g. username@hotname>"
        echo ""
        printf "Please [Enter] key to continue..." && read -r </dev/tty

        gpg --full-generate-key
        gpg --list-secret-keys --keyid-format=long

        echo ""
        echo "Input GPG key id from above. The key id is an ASCII text after 'sec  rsa4096/'."
        read -rp "GPG key ID : " gpg_key_id </dev/tty
        echo "Configuring git user.signingkey=${gpg_key_id} ..."
        git config --global user.signingkey "${gpg_key_id}"
        echo "Configuring git commit.gpgsign=true ..."
        git config --global commit.gpgsign true
        echo "Configuring git tag.gpgSign=true ..."
        git config --global tag.gpgSign true

        echo "Please add the following GPG public key in your GitHub settings:"
        gpg --armor --export "${gpg_key_id}"
    fi
fi