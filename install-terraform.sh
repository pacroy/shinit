#!/bin/sh
# Source: https://www.terraform.io/downloads.html
set -e

curl -fL https://releases.hashicorp.com/terraform/0.14.5/terraform_0.14.5_linux_amd64.zip -o $HOME/bin/terraform.zip
sudo apt-get install -y zip unzip
unzip $HOME/bin/terraform.zip -d $HOME/bin
rm $HOME/bin/terraform.zip
terraform version
