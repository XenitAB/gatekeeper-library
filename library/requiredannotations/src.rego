package k8srequiredannotations

get_message(parameters, _default) = msg {
	not parameters.message
	msg := _default
}

get_message(parameters, _default) = msg {
	msg := parameters.message
}

violation[{"msg": msg, "details": {"missing_annotations": missing}}] {
	provided := {annotation | input.review.object.metadata.annotations[annotation]}
	required := {annotation | annotation := input.parameters.annotations[_].key}
	missing := required - provided
	count(missing) > 0
	def_msg := sprintf("you must provide annotations: %v", [missing])
	msg := get_message(input.parameters, def_msg)
}

violation[{"msg": msg}] {
	value := input.review.object.metadata.annotations[key]
	expected := input.parameters.annotations[_]
	expected.key == key
	expected.allowedRegex != ""
	not re_match(expected.allowedRegex, value)
	def_msg := sprintf("Annotation <%v: %v> does not satisfy allowed regex: %v", [key, value, expected.allowedRegex])
	msg := get_message(input.parameters, def_msg)
}
