package fluxrequireserviceaccount

test_input_valid_helmrelease {
	obj = {
		"kind": {"kind": "HelmRelease"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"serviceAccountName": "foo"},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_invalid_helmrelease {
	obj = {
		"kind": {"kind": "HelmRelease"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"serviceAccountName": ""},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}

test_input_missing_helmrelease {
	obj = {
		"kind": {"kind": "HelmRelease"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}

test_input_valid_kustomization {
	obj = {
		"kind": {"kind": "Kustomization"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"serviceAccountName": "foo"},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_invalid_kustomization {
	obj = {
		"kind": {"kind": "Kustomization"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"serviceAccountName": ""},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}

test_input_missing_kustomization {
	obj = {
		"kind": {"kind": "Kustomization"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}
