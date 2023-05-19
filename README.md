# k8s_lab
k8s_lab with kind settinup an simple cluster

## good tips!

* [Kubernetes playground](https://github.com/justmeandopensource/kubernetes)

## prerequisite cli-tools

* docker or podman
* kind
* kubectl
* fzf
* kubie

## setup

```shell
#check docker / podman
which docker

which podman
podman ps

#check kubectl
which kubectl

kubectl version --short

#check kubie
which kubie

#settinup kubie
#check detials in kubie.yaml
~/.kube/kubie.yaml

cd ~/.kube/
mkdir configs

#add alias for kubie
vim ~/.bashrc

alias k='kubectl'
alias kic='kubie ctx'
alias kin='kubie ns'

#vim .kube/config

#check kind
which kind
kind create --help
kind create cluster --name hong-cluster --config kind-example.config.yaml
kind get clusters
kind get nodes --name hong-cluster

#Test env
# export KUBECONFIG=/home/hong/.kube/configs/hong-cluster.yaml
```