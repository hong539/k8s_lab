#
# ~/.bashrc
#
#extra lines for kubectl, kubie

source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k

alias kic="/usr/bin/kubie ctx"
alias kin="/usr/bin/kubie ns"
