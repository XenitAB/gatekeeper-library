package secretsstorecsiuniquevolume

violation[{"msg": msg}] {
	volumes := input.review.object.spec.volumes
	count(volumes) > 0
	volume := volumes[_]
	volume.csi.driver = "secrets-store.csi.k8s.io"

	# converts list into set, which requires unique values
	uniqueNames := {x | x = volume.csi.volumeAttributes.secretProviderClass}
	count(uniqueNames) != count(volumes)
	msg := sprintf(`'%v' cant have duplicate 'secretProviderClass'`, [input.review.kind.kind])
}
