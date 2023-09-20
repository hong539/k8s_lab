# k8s_lab
k8s_lab with kind settinup an simple cluster

## good guides and tips ...etc!

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
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
* kustomize
* [fzf](https://github.com/junegunn/fzf#using-linux-package-managers)
* [kubie](https://github.com/sbstp/kubie#installation)

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

#check kubie
which kubie

#settinup kubie
#check detials in kubie.yaml
touch ~/.kube/kubie.yaml
vim ~/.kube/kubie.yaml

#copy and paster the template from 

cd ~/.kube/
mkdir configs

#add alias for kubie
vim ~/.bashrc

alias k='kubectl'
alias kic='kubie ctx'
alias kin='kubie ns'

#vim .kube/config

#check bash
${BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions

#install kind completion bash
kind completion bash > ${BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions/kind

#Replace the shell with the given command
exec bash

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