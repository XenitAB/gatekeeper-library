# Dependencies:
# * opa
# * kustomize
# * yq

SHELL:=/bin/bash

opa-fmt:
	opa fmt -w library

opa-test: opa-fmt
	opa test library --ignore *.yaml

.ONESHELL: generate
.SILENT: generate
generate:
	set -e
	TEMPLATES_GENERATED=./charts/gatekeeper-library-templates/generated
	CONTRAINTS_GENERATED=./charts/gatekeeper-library-constraints/generated
	mkdir -p $$TEMPLATES_GENERATED $$CONTRAINTS_GENERATED
	DEFAULTS=$$CONTRAINTS_GENERATED/defaults.yaml
	echo "" > $$DEFAULTS
	LIBRARY=$$(ls -d ./library/*/)
	for D in $$LIBRARY
	do
		NAME=$$(basename $$D)
		SRC=$$(cat $$D/src.rego)
		yq w -i $$D/template.yaml "spec.targets[0].rego" "$$SRC"
		kustomize build $$D > $$TEMPLATES_GENERATED/$$NAME.yaml
		echo "$$NAME:" >> $$DEFAULTS
		yq r $$D/constraint.yaml "spec" | sed 's/^/  /' >> $$DEFAULTS
	done

helm-lint:
	helm lint charts/gatekeeper-library-constraints
	helm lint charts/gatekeeper-library-templates

helm-test:
	helm plugin install https://github.com/quintush/helm-unittest
	helm unittest --helm3 charts/gatekeeper-library-constraints
	helm unittest --helm3 charts/gatekeeper-library-templates
