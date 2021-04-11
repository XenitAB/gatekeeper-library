package secretsstorecsiuniquevolume

violation[{"msg": msg}] {
	volumes := input.review.object.spec.volumes
	count(volumes) > 0
	csiVolumes = [x | x := volumes[_]; x.csi.driver = "secrets-store.csi.k8s.io"]
	uniqueNames := {x | x = csiVolumes[_].csi.volumeAttributes.secretProviderClass}
	count(uniqueNames) != count(csiVolumes)
	msg := sprintf(`'%v' cant have duplicate 'secretProviderClass'`, [input.review.kind.kind])
}
