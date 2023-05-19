# k8s_lab
k8s_lab with kind settinup an simple cluster

## good tips!

* [Kubernetes playground](https://github.com/justmeandopensource/kubernetes)
* [rbac](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

## prerequisite cli-tools

* docker or podman
* kind
* kubectl
* kustomize
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

#kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
sudo mv kustomize /usr/local/bin/

#kustomize bash completion
sudo -s
kustomize completion bash > /usr/share/bash-completion/completions/kustomize
exit
sudo chown your_user_name /usr/share/bash-completion/completions/kustomize
source ~/.bashrc

#test kustomize build
kustomize build deployment/hong-lab/base/

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
#According --config we will create an k8s cluster with 1 control-node and 2 work nodes
kind create cluster --name hong-cluster --config kind-example.config.yaml
kind get clusters
kind get nodes --name hong-cluster

#check container images
podman images

#Test env
# export KUBECONFIG=/home/hong/.kube/configs/hong-cluster.yaml
env | grep "KUBECONFIG"

#deploy single yaml to k8s
kubectl apply -f ns.yaml --dry-run=server

#deploy objects to k8s with kustomize and kubectl
kustomize build . | kubectl apply -f - --dry-run=server
kustomize build . | kubectl apply -f -
```