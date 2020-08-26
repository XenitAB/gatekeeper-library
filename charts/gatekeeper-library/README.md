# gatekeeper-library
Library of gatekeeper constraints.

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
