#!/usr/bin/env bash

# Azure CLI
alias azset='az account set -s'
alias azls='az account list -o table'
azaks() { 
    az aks get-credentials --resource-group "${1}" --name "${2}"
}
azrolels() {
    if [ -z "${2}" ]; then
        local subscription_json="$(az account show)"
    else
        local subscription_json="$(az account show --subscription "${2}")"
    fi
    local subscription_id="$(echo "${subscription_json}" | jq -r '.id')"
    local subscription_name="$(echo "${subscription_json}" | jq -r '.name')"
    echo "Role assignments to ${1} under subscription ${subscription_id} (${subscription_name}):"
    az role assignment list --all  --output table --assignee "${1}" --subscription "${subscription_id}"
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
alias gitl1='git log --oneline --decorate'
alias gitt='git tag'
alias gittl='git tag --list -n1'
alias gitta='git tag -am'
alias gits='git status'
alias gitb='git branch -vv'
alias gitp='git push'
alias gitpt='git push --tags'
alias gitd='git diff'
alias gitu='git pull'
alias gitr='git remote -v'
alias gita='git add'
alias gitc='git commit' 
gitscan() {
    for d in */
    do
        print "\n[${d}]"
        ( cd "${d}" || return; git status )
    done
}

# Update
# shellcheck disable=SC2139
alias update-sh-init="bash ${INITDIR}/install.sh && source ${INITDIR}/init.sh"

# Standard
alias ll='ls -AlFh'
alias switch='sudo update-alternatives --config'
