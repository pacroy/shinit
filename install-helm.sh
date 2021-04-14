#!/bin/sh
# Source: https://helm.sh/docs/intro/install/   
set -e

curl -fL https://get.helm.sh/helm-v3.5.1-linux-amd64.tar.gz -o $HOME/bin/helm.tgz
tar -xzf $HOME/bin/helm.tgz -C $HOME/bin
mv $HOME/bin/linux-amd64/helm $HOME/bin
rm -rf $HOME/bin/linux-amd64
rm $HOME/bin/helm.tgz
helm version
