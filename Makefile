SHELL:=/bin/bash

all: opa-fmt opa-test generate helm-lint helm-test

opa-fmt:
	opa fmt -w library

opa-test:
	opa test library --ignore *.yaml

update-submodule:
	git submodule update --init --remote

.ONESHELL: generate
.SILENT: generate
generate: update-submodule
	set -e

	TEMPLATES_GENERATED=./charts/gatekeeper-library-templates/generated
	CONTRAINTS_GENERATED=./charts/gatekeeper-library-constraints/generated
	rm -r $$TEMPLATES_GENERATED $$CONSTRAINTS_GENERATED
	mkdir -p $$TEMPLATES_GENERATED $$CONTRAINTS_GENERATED
	DEFAULTS=$$CONTRAINTS_GENERATED/defaults.yaml
	touch $$DEFAULTS

	LIBRARY=$$(ls -d ./library/*/)
	for D in $$LIBRARY
	do
		NAME=$$(yq r $$D/constraint.yaml "kind" | tr "[:upper:]" "[:lower:]")
		SRC=$$(cat $$D/src.rego)
		yq w -i $$D/template.yaml "spec.targets[0].rego" "$$SRC"
		kustomize build $$D > $$TEMPLATES_GENERATED/$$NAME.yaml
		echo "$$NAME:" >> $$DEFAULTS
		yq r $$D/constraint.yaml "spec" | sed 's/^/  /' >> $$DEFAULTS
	done

	EXTERNAL_LIBRARY=$$(ls -d ./external/library/*/*/)
	for D in $$EXTERNAL_LIBRARY
	do
		NAME=$$(yq r $$D/template.yaml metadata.name | tr "[:upper:]" "[:lower:]")
		cat $$D/template.yaml > $$TEMPLATES_GENERATED/$$NAME.yaml
		SAMPLE=$$(ls $$D/samples/ | head -n 1)
		yq r "$${D}samples/$$SAMPLE/constraint.yaml" spec.match.kinds | yq p - $${NAME}.match.kinds >> $$DEFAULTS
		touch $$TEMPLATES_GENERATED/config-values.yaml
		if test -f $$D/sync.yaml; then
			yq r "$$D/sync.yaml" spec | yq p - $${NAME} >> $$TEMPLATES_GENERATED/config-values.yaml
		fi
	done

helm-lint:
	helm lint charts/gatekeeper-library-constraints
	helm lint charts/gatekeeper-library-templates

helm-test:
	helm plugin install https://github.com/quintush/helm-unittest
	helm unittest --helm3 charts/gatekeeper-library-constraints
	helm unittest --helm3 charts/gatekeeper-library-templates

.PHONY: e2e
e2e:
	cd e2e
	./test.sh
