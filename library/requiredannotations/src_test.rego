package k8srequiredannotations

test_input_no_required_annotations {
	input := {"review": review({"foo": "bar"}), "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_no_required_annotations {
	input := {"review": empty, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_has_annotation {
	input := {"review": review({"foo": "bar"}), "parameters": {"annotations": [anno("foo", "bar")]}}
	results := violation with input as input
	count(results) == 0
}

test_input_has_extra_annotation {
	input := {"review": review({"foo": "bar", "baz": "qux"}), "parameters": {"annotations": [anno("foo", "bar")]}}
	results := violation with input as input
	count(results) == 0
}

test_input_missing_annotation {
	input := {"review": review({"baz": "qux"}), "parameters": {"annotations": [anno("foo", "bar")]}}
	results := violation with input as input
	count(results) == 1
}

test_input_wrong_annotation_value {
	input := {"review": review({"foo": "bar"}), "parameters": {"annotations": [anno("foo", "baz")]}}
	results := violation with input as input
	count(results) == 1
}

empty = {"object": {"metadata": {"name": "nginx"}}}

review(annotations) = output {
	output = {"object": {"metadata": {
		"name": "nginx",
		"annotations": annotations,
	}}}
}

anno(k, v) = out {
	out = {"key": k, "allowedRegex": v}
}
