package secretsstorecsiuniquevolume

test_input_pod_no_volume {
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

test_input_pod_empty_volume_list {
	obj = {
		"kind": {"kind": "Pod"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"volumes": []},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_pod_emptydir_volume {
	obj = {
		"kind": {"kind": "Pod"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"volumes": [{
				"name": "foo",
				"emptyDir": {},
			}]},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_pod_valid_csi_volume {
	obj = {
		"kind": {"kind": "Pod"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"volumes": [{
				"name": "foo",
				"csi": {
					"driver": "secrets-store.csi.k8s.io",
					"readOnly": true,
					"volumeAttributes": {"secretProviderClass": "baz"},
				},
			}]},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_pod_invalid_csi_volume {
	obj = {
		"kind": {"kind": "Pod"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {"volumes": [
				{
					"name": "foo",
					"csi": {
						"driver": "secrets-store.csi.k8s.io",
						"readOnly": true,
						"volumeAttributes": {"secretProviderClass": "baz"},
					},
				},
				{
					"name": "bar",
					"csi": {
						"driver": "secrets-store.csi.k8s.io",
						"readOnly": true,
						"volumeAttributes": {"secretProviderClass": "baz"},
					},
				},
			]},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}
