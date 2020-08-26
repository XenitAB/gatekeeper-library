# Kustomize
Gatekeeper Library can be used with Kustomize, but there are some differences compared to
installing the Helm chart as the kustomization file only includes the Constraint Template by default.

The suggested usage pattern is to fetch the remote templates and then define the constraints locally.
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- github.com/XenitAB/gatekeeper-library//deploy
- constraint.yaml
---
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sRequiredAnnotations
metadata:
  name: required-annotations
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: [""]
  parameters:
    message: "Resource does not contain the required annotation"
    annotations:
      - key: "foo"
        allowedRegex: "bar"
```

If you would rather chose a specific Constraint Template to include you can do that to.
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- github.com/XenitAB/gatekeeper-library//library/k8srequiredannotations
```
