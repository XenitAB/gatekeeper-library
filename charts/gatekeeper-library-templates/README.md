# Gatekeeper Library Templates Chart
Helm chart to install Gatekeeper Library Templates on Kubernetes.

## Installation
Add the Helm repository.
```shell
helm repo add https://xenitab.github.io/gatekeeper-library/
```

Install the Gatekeeper Library Templates with the Helm chart.
```shell
helm install gatekeeper-library-templates
```

The chart will not create a single resource if you install it as is, because it does not contain
any default values. Have a look at the [values.yaml](./values.yaml) for a template to start from.

## Configuration
The following table lists the configurable parameters of the gatekeeper-library-templates chart and their default values.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| namePrefix | string | `""` | Prefix to append before resource names |
| constraints | list | `[]` | The constraints that should be created |
| constraints[].kind | string | `""` | Kind of the constraint |

## Testing
The chart is tested using the [helm-unittest](https://github.com/quintush/helm-unittest) plugin. The plugin allows
testing expected output from the chart without requiring a Kubernetes cluster. All tests should be located in the
[tests](./tests) directory and should have the `_test` suffix in the filename.
