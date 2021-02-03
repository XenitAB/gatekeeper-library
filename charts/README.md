# Gatekeeper Library Chart
Helm chart to install Gatekeeper Library on Kubernetes.

## Installation
Add the Helm repository.
```shell
helm repo add gatekeeper-library https://xenitab.github.io/gatekeeper-library/
```

Install the Gatekeeper Library with the Helm chart.
```shell
helm install gatekeeper-library/gatekeeper-library-templates --generate-name
helm install gatekeeper-library/gatekeeper-library-constraints --generate-name
```

The chart will not create a single resource if you install it as is, because it does not contain
any default values. Have a look at the [values.yaml](./values.yaml) for a template to start from.

## Configuration
The following table lists the configurable parameters of the gatekeeper-library chart and their default values.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| namePrefix | string | `""` | Prefix to append before resource names |
| constraints | list | `[]` | The constraints that should be created |
| constraints[].kind | string | `""` | Kind of the constraint |
| constraints[].name | string | `""` | Name of the constraint, should be unique in the list |
| constraints[].parameters | list | `[]` | Additional parameters to pass to the constraint |

## Testing
The chart is tested using the [helm-unittest](https://github.com/quintush/helm-unittest) plugin. The plugin allows
testing expected output from the chart without requiring a Kubernetes cluster. All tests should be located in the
[tests](./tests) directory and should have the `_test` suffix in the filename.
