SHELL=/bin/bash

all: opa-fmt opa-test generate helm-lint helm-test

opa-fmt:
	opa fmt -w library

opa-test:
	opa test library --ignore *.yaml

update-external:
	git submodule update --init --remote

get-external:
	git submodule update --init

.ONESHELL: generate
.SILENT: generate
generate: get-external
	set -e

	TEMPLATES_GENERATED=./charts/gatekeeper-library-templates/generated
	CONTRAINTS_GENERATED=./charts/gatekeeper-library-constraints/generated
	rm -r $$TEMPLATES_GENERATED
	mkdir -p $$TEMPLATES_GENERATED $$CONTRAINTS_GENERATED
	CONSTRAINT_DEFAULTS=$$CONTRAINTS_GENERATED/constraint-defaults.yaml
	> $$CONSTRAINT_DEFAULTS

	ASSIGN_LIBRARY=$$(ls -d ./library/assigns/*)
	for D in $$ASSIGN_LIBRARY
	do
		FILENAME=$$(basename $$D)
		cp $$D $$CONTRAINTS_GENERATED/$$FILENAME
	done

	MODIFYSETS_LIBRARY=$$(ls -d ./library/modifysets/*)
	for D in $$MODIFYSETS_LIBRARY
	do
		FILENAME=$$(basename $$D)
		cp $$D $$CONTRAINTS_GENERATED/$$FILENAME
	done

	CONSTRAINT_LIBRARY=$$(ls -d ./library/constraints/*/)
	for D in $$CONSTRAINT_LIBRARY
	do
		NAME=$$(yq '.kind' $$D/constraint.yaml | tr "[:upper:]" "[:lower:]")
		SRC=$$(cat $$D/src.rego)
		SRC=$$SRC yq -i '.spec.targets[0].rego = strenv(SRC)' $$D/template.yaml
		kustomize build $$D > $$TEMPLATES_GENERATED/$$NAME.yaml
		echo "$$NAME:" >> $$CONSTRAINT_DEFAULTS
		yq '.spec' $$D/constraint.yaml | sed 's/^/  /' >> $$CONSTRAINT_DEFAULTS
	done

	EXTERNAL_LIBRARY=$$(ls -d ./external/library/*/*/)
	for D in $$EXTERNAL_LIBRARY
	do
	    if [[ -f $$D/template.yaml ]]; then
			NAME=$$(yq '.metadata.name' $$D/template.yaml | tr "[:upper:]" "[:lower:]")
			cat $$D/template.yaml > $$TEMPLATES_GENERATED/$$NAME.yaml
			SAMPLE=$$(ls $$D/samples/ | head -n 1)
			yq '.spec.match.kinds // {}' "$${D}samples/$$SAMPLE/constraint.yaml" | yq "{\"$$NAME\": {\"match\": {\"kinds\": . }}}" >> $$CONSTRAINT_DEFAULTS
			touch $$TEMPLATES_GENERATED/config-values.yaml
			if test -f $$D/sync.yaml; then
				yq '.spec' "$$D/sync.yaml" | yq "{\"$$NAME\": . }" >> $$TEMPLATES_GENERATED/config-values.yaml
			fi
		fi
	done

helm-lint:
	helm lint charts/gatekeeper-library-constraints
	helm lint charts/gatekeeper-library-templates

helm-test:
	helm plugin install --version v0.3.3 https://github.com/helm-unittest/helm-unittest
	helm unittest charts/gatekeeper-library-constraints
	helm unittest charts/gatekeeper-library-templates

.PHONY: e2e
e2e:
	cd e2e
	./test.sh
