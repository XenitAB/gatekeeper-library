package k8spodpriorityclass

violation[{"msg": msg}] {
	input.review.kind.kind == "Pod"
	permittedClassNames := get_class_names(input.parameters, [""])
	not contains(permittedClassNames, input.review.object.spec.priorityClassName)
	msg := sprintf(`The priority class name '%v' is not allowed`, [input.review.object.spec.priorityClassName])
}

get_class_names(parameters, _default) = msg {
	not parameters.permittedClassNames
	msg := _default
}

get_class_names(parameters, _default) = msg {
	msg := parameters.permittedClassNames
}

contains(arr, elem) {
	arr[_] = elem
}
