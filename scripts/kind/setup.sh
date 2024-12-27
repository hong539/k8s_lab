#!/usr/bin/env bash
set -euxo pipefail

#check docker / podman
which docker

which podman
podman ps

#check kubectl
#setting up for kubectl alilas
which kubectl

kubectl version --client

#kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
sudo mv kustomize /usr/local/bin/

#kustomize bash completion
sudo -s
# kustomize completion bash > /usr/share/bash-completion/completions/kustomize
kustomize completion bash > ${BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions/kustomize
exec bash

#test kustomize build
kustomize build deployment/hong-lab/base/

#install kubie
wget https://github.com/sbstp/kubie/releases/download/v0.22.0/kubie-linux-amd64

mv kubie-linux-amd64 kubie
chmod +x kubie
sudo mv kubie /usr/local/bin/

#check kubie
which kubie

#add alias for kubie
vim ~/.bashrc

alias k='kubectl'
alias kic='kubie ctx'
alias kin='kubie ns'

#vim .kube/config

#check bash
mkdir -p ${BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions

#Replace the shell with the given command
exec bash

#install go
wget https://go.dev/dl/go1.21.4.linux-amd64.tar.gz
rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz
exec bash

go version
which go

#install kind
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

#check kind
which kind

#install kind completion bash
kind completion bash > ${BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions/kind

kind create --help
#creat local k8s cluster with config file
#According --config we will create an k8s cluster with 1 control-node and 2 work nodes
cd architecture/
kind create cluster --name hong-cluster --config kind-example.config.yaml

#delete
kind delete cluster --name hong-cluster

#ERROR: failed to create cluster: running kind with rootless provider requires cgroup v2, see https://kind.sigs.k8s.io/docs/user/rootless/
sudo vim /etc/default/grub
#add this to /etc/default/grub
GRUB_CMDLINE_LINUX="systemd.unified_cgroup_hierarchy=1"

#update
sudo update-grub

#
sudo mkdir -p /etc/systemd/system/user@.service.d/
cat <<EOF > /etc/systemd/system/user@.service.d/delegate.conf
[Service]
Delegate=yes
EOF

#
cat <<EOF > /etc/modules-load.d/iptables.conf
ip6_tables
ip6table_nat
ip_tables
iptable_nat
EOF

cat <<EOF > /etc/modules-load.d/test.conf
ip6_tables
ip6table_nat
ip_tables
iptable_nat
EOF

# echo "ip6_tables ip6table_nat ip_tables iptable_nat" | sudo tee /etc/modules-load.d/test.conf

#check cluster
kind get clusters
kind get nodes --name hong-cluster

#Deletes one of [cluster]
kind delete cluster --name hong-cluster

#ops with kind cluster
kic

#leave with exit
exit

#settinup kubie with ~/.kube
#check detials in kubie.yaml
touch ~/.kube/kubie.yaml

#copy and paste the yaml codes from k8s_lab/env/kubie.yaml
vim ~/.kube/kubie.yaml

mkdir -p ~/.kube/configs

#mv config to configs and edit name
mv ~/.kube/config ~/.kube/configs/kind-hong-cluster.yaml

#test wuth uchan
kic
kin

k create ns hong-lab
k create ns uchan
k create ns varnish-operator

#output
# enabling experimental podman provider
# Deleting cluster "hong-cluster" ...
# Deleted nodes: ["hong-cluster-worker" "hong-cluster-worker2" "hong-cluster-control-plane"]