package k8srequireingressclass

test_input_class_not_set {
	obj = {
		"kind": {"kind": "Ingress"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}

test_input_class_empty_string {
	obj = {
		"kind": {"kind": "Ingress"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"ingressClassName": ""},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}

test_input_class_set {
	obj = {
		"kind": {"kind": "Ingress"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"ingressClassName": "nginx"},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}
