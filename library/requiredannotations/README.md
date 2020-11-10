# Required Annotations
Enforces annotations be presenet on sepecific created resources.

## Examples
Require Ingress resources to sepcify an ingress class.
```yaml
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sRequiredAnnotations
metadata:
  name: ingress-class
spec:
  enforcementAction: deny
  match:
    kinds:
      - apiGroups: ["extensions", "networking.k8s.io"]
        kinds: ["Ingress"]
  parameters:
    message: "Resource does not contain the required annotation"
    annotations:
    - key: "kubernetes.io/ingress.class"
      allowedRegex: "nginx"
```
