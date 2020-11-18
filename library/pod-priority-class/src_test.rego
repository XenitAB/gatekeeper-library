package k8spodpriorityclass

test_input_class_not_set {
	obj = {
		"kind": {"kind": "Pod"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_no_permitted_valid {
	obj = {
		"kind": {"kind": "Pod"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"priorityClassName": ""},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_no_permitted_valid {
	obj = {
		"kind": {"kind": "Pod"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"priorityClassName": "foobar"},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}

test_input_one_permitted_valid {
	obj = {
		"kind": {"kind": "Pod"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"priorityClassName": "foo"},
		},
	}

	input := {"review": obj, "parameters": {"permittedClassNames": ["foo"]}}
	results := violation with input as input
	count(results) == 0
}

test_input_one_permitted_invalid {
	obj = {
		"kind": {"kind": "Pod"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"priorityClassName": "bar"},
		},
	}

	input := {"review": obj, "parameters": {"permittedClassNames": ["foo"]}}
	results := violation with input as input
	count(results) == 1
}
