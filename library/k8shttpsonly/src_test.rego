package k8shttpsonly

test_input_uses_https {
	input := {"review": input_review_valid, "parameters": {}}
	results := violation with input as input
	count(results) == 0
}

test_input_not_uses_https {
	input := {"review": input_review_invalid, "parameters": {}}
	results := violation with input as input
	count(results) == 1
}

input_review_valid = {"object": {
	"metadata": {"name": "foo"},
	"spec": {"tls": [{}]},
}}

input_review_invalid = {"object": {
	"metadata": {"name": "foo"},
	"spec": {"tls": []},
}}
