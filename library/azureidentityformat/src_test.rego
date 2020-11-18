package azureidentityformat

test_input_valid {
	obj = {
		"kind": {"kind": "AzureIdentity"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {
				"type": 0,
				"resourceID": "/subscriptions/<subid>/resourcegroups/<resourcegroup>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<name>",
			},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_invalid {
	obj = {
		"kind": {"kind": "AzureIdentity"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {
				"type": 0,
				"resourceID": "foobar",
			},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}
