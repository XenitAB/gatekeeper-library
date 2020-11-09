package k8shttpsonly

violation[{"msg": msg}] {
	ingress := input.review.object
	not https_complete(ingress)
	msg := "Ingress must be https, TLS configuration is required"
}

https_complete(ingress) {
	ingress.spec.tls
	count(ingress.spec.tls) > 0
}
