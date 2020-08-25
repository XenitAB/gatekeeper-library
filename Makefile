# Dependencies:
# * opa
# * kustomize
# * yq

SHELL:=/bin/bash

opa-fmt:
	opa fmt -w library

opa-test: fmt
	opa test library --ignore *.yaml

.ONESHELL: generate
.SILENT: generate
generate:
	set -e
	GENERATED=./charts/gatekeeper-library/generated
	DEFAULTS=$$GENERATED/defaults.yaml
	LIBRARY=$$(ls -d ./library/*/)
	mkdir -p $$GENERATED
	rm -f $$DEFAULTS
	touch $$DEFAULTS
	for D in $$LIBRARY
	do
		NAME=$$(basename $$D)
		SRC=$$(cat $$D/src.rego)
		yq w -i $$D/template.yaml "spec.targets[0].rego" "$$SRC"
		kustomize build $$D > $$GENERATED/$$NAME.yaml
		echo "$$NAME:" >> $$DEFAULTS
		yq r $$D/constraint.yaml "spec" | sed 's/^/  /' >> $$DEFAULTS
	done

helm-lint:
	helm lint charts/gatekeeper-library

helm-test:
	helm unittest --helm3 charts/gatekeeper-library
