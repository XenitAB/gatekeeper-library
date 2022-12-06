#!/bin/bash
set -e

kubectl create namespace gatekeeper-system --dry-run=client -o yaml | kubectl apply -f -
helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
helm repo update
helm upgrade --version "v3.9.0" --install --namespace gatekeeper-system gatekeeper gatekeeper/gatekeeper
helm upgrade --install --namespace gatekeeper-system -f values.yaml templates ../charts/gatekeeper-library-templates
helm upgrade --install --namespace gatekeeper-system -f values.yaml constraints ../charts/gatekeeper-library-constraints
