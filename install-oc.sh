#!/bin/sh
# Source: https://docs.openshift.com/container-platform/3.11/cli_reference/get_started_cli.html#cli-linux
set -e

az acocunt show --subscription 172f7750-929c-4214-99fb-e1e8d9e582f2
az storage blob download \
    --subscription 172f7750-929c-4214-99fb-e1e8d9e582f2 \
    --account-name asok \
    --container-name samyan \
    --auth-mode login \
    --name oc-3.11.374-linux.tar.gz \
    --file $HOME/bin/oc.tgz
tar -xzf $HOME/bin/oc.tgz -C $HOME/bin
rm $HOME/bin/oc.tgz
oc version
