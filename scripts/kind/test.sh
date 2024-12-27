#!/usr/bin/env bash
set -euxo pipefail
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