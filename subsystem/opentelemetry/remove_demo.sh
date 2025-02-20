#!/usr/bin/env bash
set -euxo pipefail

helm uninstall my-otel-demo

helm ls