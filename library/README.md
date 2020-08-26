# Library
The library contains all of the available policies. Each directory contains a single policy.

## Development
Each policy directory should contain the following files:
* src.rego
* src_test.rego
* template.yaml
* sync.yaml (optional)
* constraint.yaml
* kustomization.yaml
* README.md

The kustomization file should include the `template.yaml` file and optionally the `sync.yaml` file if one exists.
It should **not** include the `constraint.yaml` file as it would both break the generation scripts and common use cases.

The generation script needs to be run after any changes to any file in the library directory has been done. This is to make
sure that the Helm chart is in sync with the library.
```shell
make generate
```

## Testing
Testing of the rego is done with OPA test. All of the tests are run as part of CI test suite, but can also be run locally.
```shell
make opa-test
```
