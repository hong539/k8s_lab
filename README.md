# k8s_lab
k8s_lab with kind settinup an simple cluster

## good tips!

* [Kubernetes playground](https://github.com/justmeandopensource/kubernetes)

## prerequisite

* docker or podman
* kind
* kubectl
* kubie

## setup

```shell
#check docker / podman
which docker

which podman
podman ps

#check kubectl
which kubectl

#check kubie
which kubie

#check kind
which kind
kind create --help
kind create cluster --name hong-cluster --config kind-example.config.yaml
kind get clusters
kind get nodes --name hong-cluster
```