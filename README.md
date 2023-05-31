# k8s_lab
k8s_lab with kind settinup an simple cluster

## good guides and tips!

* [k8s/components](https://kubernetes.io/docs/concepts/overview/components/)
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

#check cluster
kind get clusters
kind get nodes --name hong-cluster

#Deletes one of [cluster]
kind delete cluster --name hong-cluster

#output
# enabling experimental podman provider
# Deleting cluster "hong-cluster" ...
# Deleted nodes: ["hong-cluster-worker" "hong-cluster-worker2" "hong-cluster-control-plane"]

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

## Important!!!

== We're Using GitHub Under Protest ==

This project is currently hosted on GitHub.  This is not ideal; GitHub is a
proprietary, trade-secret system that is not Free and Open Souce Software
(FOSS).  We are deeply concerned about using a proprietary system like GitHub
to develop our FOSS project.  We have an
[open {bug ticket, mailing list thread, etc.} ](INSERT_LINK) where the
project contributors are actively discussing how we can move away from GitHub
in the long term.  We urge you to read about the
[Give up GitHub](https://GiveUpGitHub.org) campaign from
[the Software Freedom Conservancy](https://sfconservancy.org) to understand
some of the reasons why GitHub is not a good place to host FOSS projects.

If you are a contributor who personally has already quit using GitHub, please
[check this resource](INSERT_LINK) for how to send us contributions without
using GitHub directly.

Any use of this project's code by GitHub Copilot, past or present, is done
without our permission.  We do not consent to GitHub's use of this project's
code in Copilot.

![Logo of the GiveUpGitHub campaign](https://sfconservancy.org/img/GiveUpGitHub.png)