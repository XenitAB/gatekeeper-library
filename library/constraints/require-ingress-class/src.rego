package k8srequireingressclass

violation[{"msg": msg}] {
	input.review.kind.kind == "Ingress"
	not input.review.object.spec.ingressClassName
	msg := "Ingress class name has to be set"
}

violation[{"msg": msg}] {
	input.review.kind.kind == "Ingress"
	input.review.object.spec.ingressClassName == ""
	msg := "Ingress class name cannot be an emtpy string"
}
