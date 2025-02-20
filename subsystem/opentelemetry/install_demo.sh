#!/usr/bin/env bash
set -euxo pipefail

# docs: https://opentelemetry.io/docs/platforms/kubernetes/helm/demo/
# src: https://github.com/open-telemetry/opentelemetry-demo
# helm-chart values: https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-demo#chart-parameters
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

helm install my-otel-demo open-telemetry/opentelemetry-demo

# kubectl port-forward svc/my-otel-demo-frontendproxy 8080:8080

kubectl --namespace hong-lab port-forward svc/frontend-proxy 8080:8080

#   Webstore             http://localhost:8080/
#   Jaeger UI            http://localhost:8080/jaeger/ui/
#   Grafana              http://localhost:8080/grafana/
#   Load Generator UI    http://localhost:8080/loadgen/
#   Feature Flags UI     http://localhost:8080/feature/