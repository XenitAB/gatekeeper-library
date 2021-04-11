package azureidentityformat

test_input_valid {
	obj = {
		"kind": {"kind": "AzureIdentity"},
		"object": {
			"metadata": {"name": "some-name"},
			"spec": {
				"type": 0,
				"resourceID": "/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/myResourceGroup/providers/Microsoft.ManagedIdentity/userAssignedIdentities/testidentity",
				"clientID": "00000000-0000-0000-0000-000000000000",
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
				"clientID": "00000000-0000-0000-0000-000000000000",
			},
		},
	}

	input := {"review": obj, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}
