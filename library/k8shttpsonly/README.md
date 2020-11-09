# Https Only
Enforces that ingress resources enable https.

## Examples
Require Ingress resources to add tls configuration.
```yaml
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sHttpsOnly
metadata:
  name: https-only
spec:
  match:
    kinds:
      - apiGroups: ["extensions", "networking.k8s.io"]
        kinds: ["Ingress"]
```
