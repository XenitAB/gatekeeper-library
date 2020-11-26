package fluxdisablecrossnamespacesource

violation[{"msg": msg}] {
	check_kind(input.review.kind.kind)
	input.review.object.spec.sourceRef.namespace
	input.review.object.spec.sourceRef.namespace != input.review.object.metadata.namespace
	msg := sprintf(`'%v' in namespace '%v' cant use source in different namespace '%v'`, [input.review.kind.kind, input.review.object.metadata.namespace, input.review.object.spec.sourceRef.namespace])
}

check_kind(kind) {
	kind == "HelmRelease"
}

check_kind(kind) {
	kind == "Kustomization"
}
