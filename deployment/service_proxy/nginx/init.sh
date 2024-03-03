#!/bin/bash

kubectl create secret tls ssl-certificate --cert=fullchain.pem --key=privkey.pem
kubectl create configmap nginx-config --from-file=./conf/nginx.conf

kubectl apply -f nginx-deployment.yaml