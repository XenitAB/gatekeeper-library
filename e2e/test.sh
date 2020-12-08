#!/bin/bash

helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
helm upgrade --install gatekeeper gatekeeper/gatekeeper
helm upgrade --install -f values.yaml templates ../charts/gatekeeper-library-templates/
helm upgrade --install -f values.yaml constraints ../charts/gatekeeper-library-constraints/
