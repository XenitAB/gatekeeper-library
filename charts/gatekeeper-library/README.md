# gatekeeper-library
Library of gateeper constraints.

## Configuration
The following table lists the configurable parameters of the gateeper-library chart and their default values.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| namePrefix | string | `""` | Prefix to append before resource names |
| constraints | list | `[]` | The constraints that should be created |
| constraints[].kind | string | `""` | Kind of the constraint |
| constraints[].name | string | `""` | Name of the constraint, should be unique in the list |
| constraints[].parameters | list | `[]` | Additional parameters to pass to the constraint |

## Testing
[helm-unittest](https://github.com/quintush/helm-unittest)
