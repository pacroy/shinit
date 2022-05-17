#!/usr/bin/env bash

# Azure CLI
alias azset='az account set -s'
alias azls='az account list -o table'
azaks() { 
    az aks get-credentials --resource-group "${1}" --name "${2}"
}
azrolels() {
    if [ -z "${2}" ]; then
        local subscription_json
        subscription_json="$(az account show)"
    else
        local subscription_json
        subscription_json="$(az account show --subscription "${2}")"
    fi
    local subscription_id
    subscription_id="$(echo "${subscription_json}" | jq -r '.id')"
    local subscription_name
    subscription_name="$(echo "${subscription_json}" | jq -r '.name')"
    echo "Role assignments to ${1} under subscription ${subscription_id} (${subscription_name}):"
    az role assignment list --all  --output table --assignee "${1}" --subscription "${subscription_id}"
}
azrolecr() {
    if [ -z "${1}" ] || [ "${1}" = "-h" ] || [ "${1}" = "--help" ]; then
        printf 'Create a new role assignment\n\n'
        printf 'Usage: azrolecr <assignee> <role> <scope>\n\n'
        printf '  <assignee> : Object id, user sign-in name, or service principal name\n'
        printf '  <role>     : Role name or id\n'
        printf '  <scope>    : e.g. /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup\n\n'
    else
        az role assignment create --assignee "${1}" --role "${2}" --scope "${3}" --output table
    fi
}

# AWS CLI
alias awsuser='aws iam get-user'
alias awsconfig='aws configure list'
alias awsprofile='aws configure list-profiles'
awsset() {
    if [ -n "${1}" ]; then 
        export AWS_PROFILE="${1}"
    else
        unset AWS_PROFILE
    fi
}

# Kubernetes CLI
alias kc='kubectl'
alias kcls='kubectl config get-contexts'
alias kcuse='kubectl config use-context'
kcsetns() { 
    kubectl config set-context "$(kubectl config current-context)" --namespace "${1}"
}
kcstatus() { 
    kubectl rollout status deploy "${1}"
}
kcskiptls() {
    kubectl config set-cluster "${1}" --insecure-skip-tls-verify=true
}

# OpenShift CLI
alias ocls='oc config get-contexts'
alias ocuse='oc config use-context'

# Terraform & Terragrunt
unalias tf tg 2> /dev/null
alias tf='terraform'
alias tg='terragrunt'

# Git
alias gitl='git log'
alias gitl1="git log --oneline --decorate --format=format:'%C(blue)%h%C(reset) %C(green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(yellow)%d%C(reset)'"
# git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
alias gitt='git tag'
alias gittl='git tag --list -n1 --sort=-tag'
alias gitta='git tag -am'
alias gits='git status'
alias gitb='git branch -vv'
alias gitp='git push'
alias gitpt='git push --tags'
alias gitptf='git push --tags --force'
alias gitd='git diff'
alias gitu='git pull'
alias gitut='git pull --prune --tags --force'
alias gitr='git remote'
alias gitrl='git remote -v'
alias gita='git add'
alias gitc='git commit'
alias gitca='git commit -am'
alias gitf='git fetch'
alias gitsha='git rev-parse --short HEAD'
alias gitscan='${INITDIR}/python/gitscan.py'

# sh commands
alias shupdate='bash ${INITDIR}/install.sh && source ${INITDIR}/init.sh'
shinstall() { 
    if [ -f "$INITDIR/install/$1.sh" ]; then
        "$INITDIR/install/$1.sh"
    else
        >&2 echo "Install script for '$1' does not exist."
    fi
}
shversion() {
    (
        cd "$INITDIR" || return
        git rev-parse --short HEAD
        git submodule status
    )
}

# Standard
alias ll='ls -AlFh'
alias switch='sudo update-alternatives --config'
