gatekeeper-library
==================
Library collection of gateeper constraints

Current chart version is `v0.1.0`

Source code can be found [here](https://github.com/xenitab/gatekeeper-library)



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| constraints | list | `[{"kind":"k8srequiredannotations"}]` | Constraints to create |
| constraints[0].kind | string | `"k8srequiredannotations"` | foobar |
| namePrefix | string | `""` | Prefix to append before resource names |
