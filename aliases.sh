# Azure CLI
unalias azset azls 2> /dev/null
unset azaks
alias azset='az account set -s'
alias azls='az account list -o table'
azaks() { 
    az aks get-credentials --resource-group $1 --name $2
}

# Kubernetes CLI
unalias kc kcls kcuse 2> /dev/null
unset kcsetns kcstatus
alias kc='kubectl'
alias kcls='kc config get-contexts'
alias kcuse='kc config use-context'
kcsetns() { 
    kc config set-context $(kc config current-context) --namespace $1
}
kcstatus() { 
    kc rollout status deploy $1
}

# OpenShift CLI
unalias ocls ocuse 2> /dev/null
alias ocls='oc config get-contexts'
alias ocuse='oc config use-context'

# Terraform & Terragrunt
unalias tf tg 2> /dev/null
alias tf='terraform'
alias tg='terragrunt'

# Git
unalias gitl gitt gits gitb gitp gitpt gitd gitu 2> /dev/null
unset gitscan gita gitc gitz
alias gitl='git log --oneline --decorate --all'
alias gitt='git tag -n1'
alias gits='git status --ignored'
alias gitb='git branch -vv'
alias gitp='git push --follow-tags'
alias gitpt='git push --tags --force'
alias gitd='git diff'
alias gitu='git pull'
gitscan() {
    for d in */
    do
        echo -e "[$d]"
        cd $d
        git status
        cd ..
        echo ""
    done
}
gita() {
    git add "$@"
}
gitc() { 
    git commit -m "$1" 
}
gitac() { 
    git commit -am "$1" 
}
gitz() { 
    gita .
    gitc "$1"
    gitp 
}

# Alias
unalias update-alias 2> /dev/null
alias update-alias='curl -sSL https://par.sh/alias -o ~/alias.sh -x "$proxy" && source ~/alias.sh'

# Standard
alias ll='ls -AlFh'