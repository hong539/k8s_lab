#!/usr/bin/env bash
set -euxo pipefail
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