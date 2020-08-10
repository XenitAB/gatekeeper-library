# Kustomize

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- github.com/XenitAB/gatekeeper-library//deploy
```

Or you can add specific constraint by linking to them individually.
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- github.com/XenitAB/gatekeeper-library//library/k8srequiredannotations
```
