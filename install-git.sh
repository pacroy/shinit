#!/bin/sh
# Source: http://lifeonubuntu.com/upgrading-ubuntu-to-use-the-latest-git-version/
set -e

sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get install -y git
