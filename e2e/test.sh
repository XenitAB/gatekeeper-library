#!/bin/bash

helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
helm install gatekeeper/gatekeeper --generate-name

helm install -f valus.yaml ../charts/gatekeeper-library-templates


