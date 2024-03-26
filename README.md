# k8s_lab
k8s_lab with kind settinup an simple cluster

## good guides and tips ...etc!

* [kubectl rollout](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/)
* [kubectl cp](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_cp/)
* [kubectl diff](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_diff/)
* [kubectl debug](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_debug/)
* [netshoot: a Docker + Kubernetes network trouble-shooting swiss-army container](https://github.com/nicolaka/netshoot)
* [Need some explaination of kubectl stdin and pipe](https://stackoverflow.com/questions/54032336/need-some-explaination-of-kubectl-stdin-and-pipe)
* [Why dig does not resolve K8s service by dns name while nslookup has no problems with it?](https://stackoverflow.com/questions/50668124/why-dig-does-not-resolve-k8s-service-by-dns-name-while-nslookup-has-no-problems)
* [Workloads](https://kubectl.docs.kubernetes.io/guides/introduction/resources_controllers/#workloads)
* [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
    * [Access Modes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes)
    * [uchan/Installation](https://floens.github.io/uchan/installation.html)
    * k8s NFS Output: mount.nfs: Operation not permitted
    * [I was trying to create a pvc with RWX access mode in the kind cluster. I see an error that it is not supported.](https://github.com/kubernetes-sigs/kind/issues/2371)
    * [Enable Simulation of automatically provisioned ReadWriteMany PVs](https://github.com/kubernetes-sigs/kind/issues/1487)
* [docker Language-specific guides](https://docs.docker.com/language/)
* [DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)
* [Service type](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types)
* [k8s/components](https://kubernetes.io/docs/concepts/overview/components/)
* [rbac](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
* [install-bash-auto-completion](https://hhming.moe/post/install-bash-auto-completion/)
* [Spring Cloud for Microservices Compared to Kubernetes](https://developers.redhat.com/blog/2016/12/09/spring-cloud-for-microservices-compared-to-kubernetes)
* [Re: [請益] 雲端技術是Java工程師的必備技能嗎](https://www.ptt.cc/bbs/Soft_Job/M.1694682456.A.435.html)
* [架構師觀點: 你需要什麼樣的 CI / CD ?](https://columns.chicken-house.net/2017/08/05/what-cicd-do-you-need/#%E7%B5%90%E8%AB%96-%E5%9F%B7%E8%A1%8C%E6%9E%B6%E6%A7%8B%E8%88%87%E6%96%B9%E5%90%91)
* [如何读懂火焰图？ Flamegraph](https://www.ruanyifeng.com/blog/2017/09/flame-graph.html)

## prerequisite cli-tools

* container runtime/engine, just choose one for kind
    * [docker engine](https://docs.docker.com/engine/install/)
        * [rootless](https://docs.docker.com/engine/security/rootless/#how-it-works)
    * [podman](https://podman.io/docs/installation#installing-on-linux)
* [kind](https://kind.sigs.k8s.io/)
    * [[ Kube 43.2 ] Getting started with KinD | Local multi-node k8s cluster in Docker containers](https://youtu.be/kkW7LNCsK74)
    * [如何在 Bash 安裝新的自動補齊手稿](https://hhming.moe/post/install-bash-auto-completion/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
* [kustomize](https://kubectl.docs.kubernetes.io/)
* [fzf](https://github.com/junegunn/fzf#using-linux-package-managers)
* [kubie](https://github.com/sbstp/kubie#installation)
    * [Autocompletion](https://github.com/sbstp/kubie#autocompletion)

## setup

```shell
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
```

```shell
#Setting Up An Ingress Controller
#src: https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx
#ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

#test ingress
#kin hong-lab
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml  

# should output "foo-app"
curl localhost:38000/foo/hostname
# should output "bar-app"
curl localhost:38000/bar/hostname
```

```shell
#check container images
podman images

#Test env
# export KUBECONFIG=/home/hong/.kube/configs/hong-cluster.yaml
env | grep "KUBECONFIG"

#deploy single yaml to k8s
kubectl apply -f ns.yaml --dry-run=server

#port-forward
kubectl port-forward services/postgres-svc 9000:5432

#deploy objects to k8s with kustomize and kubectl
kustomize build . | kubectl apply -f - --dry-run=server
kustomize build . | kubectl apply -f -

#test with ubuntu image
kubectl run test-ubuntu --image=ubuntu --restart=Never -- sleep 1d
```

## deployments/services

* [local_library_website](https://github.com/hong539/local_library_website)
* [SRS4](https://ossrs.net/lts/zh-cn/docs/v4/doc/introduction)


## sub-systems

* [Ingress NGINX Controller](https://github.com/kubernetes/ingress-nginx/)
    * [SSL Passthrough](https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/tls.md#ssl-passthrough)
    * [Exposing TCP and UDP services](https://kubernetes.github.io/ingress-nginx/user-guide/exposing-tcp-udp-services/)
    * [Exposing FastCGI Servers](https://kubernetes.github.io/ingress-nginx/user-guide/fcgi-services/)
        * php-fpm nginx
            * [PHP-FPM + Nginx on Kubernetes](https://stackoverflow.com/questions/49494602/php-fpm-nginx-on-kubernetes)
            * [Has anyone been able to configure nginx-ingress -> fpm ? Been unable to configure this](https://github.com/kubernetes/ingress-nginx/issues/8207)
* [metrics-server](https://github.com/kubernetes-sigs/metrics-server)
* [fluentbit](https://docs.fluentbit.io/manual/installation/kubernetes)
* [Reloader](https://github.com/stakater/Reloader)
* [gitlab runner](https://docs.gitlab.com/runner/install/kubernetes.html)
* [emqx-operator](https://github.com/emqx/emqx-operator)
    * [Specify secrets for listeners TLS certificates](https://github.com/emqx/emqx-operator/issues/110)
    * SSL/TLS TLS termination proxy part
* [nacos](https://nacos.io/zh-cn/docs/what-is-nacos.html)
    * discovery each node nacos cluster mode 
        * [dns issue for nacos cluser mode](https://github.com/nacos-group/nacos-k8s/issues?q=dns)
    * [Kubernetes Nacos](https://nacos.io/zh-cn/docs/use-nacos-with-kubernetes.html)
    * [nacos-k8s](https://github.com/nacos-group/nacos-k8s)
        * [nacos-operator](https://github.com/nacos-group/nacos-k8s/blob/master/operator/README.md)
* [kubevirt](https://kubevirt.io/)
    * [Cloud Native Live: Making VMs a first-class citizen in Kubernetes with KubeVirt](https://youtu.be/vMYQeFJX0Dk)
* [RabbitMQ](https://www.rabbitmq.com/kubernetes/operator/operator-overview.html)
* [prometheus](https://prometheus.io/docs/prometheus/latest/installation/)
    * [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus)
* ELK(Elastic Search/Logstash/Kibana) stack or EFK(Elastic Search/fluentbit/Kibana) stack
    * [Elastic Cloud on Kubernetes](https://www.elastic.co/downloads/elastic-cloud-kubernetes)
        * [Quickstart](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-quickstart.html)
    * [fluentbit](https://fluentbit.io/)
        * [installation](https://docs.fluentbit.io/manual/installation/kubernetes#installation)
    * [elastalert2](https://github.com/jertel/elastalert2)

```shell
#For test metrics-server
kubectl top nodes
kubectl top pods
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