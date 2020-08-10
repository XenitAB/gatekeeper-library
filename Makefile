# Dependencies:
# * opa
# * kustomize
# * yq

SHELL:=/bin/bash

fmt:
	opa fmt -w library

test: fmt
	opa test library --ignore *.yaml

.ONESHELL: generate
.SILENT: generate
generate: test
	mkdir -p charts/gatekeeper-library/library
	DIR=$$(ls -d ./library/*/)
	for D in $$DIR
	do
		SRC=$$(cat $$D/src.rego)
		yq write -i $$D/template.yaml "spec.targets[0].rego" "$$SRC"
		NAME=$$(basename $$D)
		kustomize build $$D > ./charts/gatekeeper-library/library/$$NAME.yaml
	done

docs:
	helm-docs
