# Secrets Store CSI Unique Volume

Rule used with [secrets-store-csi-driver](https://github.com/kubernetes-sigs/secrets-store-csi-driver), it restricts a Pod from having two csi volumes that reference the same `secretProviderClass`.
Secret updating will break if the same `secretProviderClass` is used as the reconcile will error with a non specific error log in
[secretproviderclasspodstatus_controller.go](https://github.com/kubernetes-sigs/secrets-store-csi-driver/blob/7035879aabbbf778ed31bcea7f8ef2de6395e2bf/controllers/secretproviderclasspodstatus_controller.go#L255).
It is easier to stop this misstake before applying the manifest instead of having to debug why secrets stop updating.

Example of volume configuration that is blocked by this constraint.

```yaml
volumes:
  - name: foo
    csi:
      driver: secrets-store.csi.k8s.io
      readOnly: true
      volumeAttributes:
        secretProviderClass: baz
  - name: bar
    csi:
      driver: secrets-store.csi.k8s.io
      readOnly: true
      volumeAttributes:
        secretProviderClass: baz
```
