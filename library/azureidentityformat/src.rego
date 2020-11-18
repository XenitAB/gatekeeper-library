package azureidentityformat

violation[{"msg": msg}] {
	input.review.kind.kind == "AzureIdentity"

	# format of resourceId is checked only for user-assigned MSI
	input.review.object.spec.type == 0
	resourceId := input.review.object.spec.resourceID
	result := re_match(`(?i)/subscriptions/(.+?)/resourcegroups/(.+?)/providers/Microsoft.ManagedIdentity/(.+?)/(.+)`, resourceId)
	result == false
	msg := sprintf(`The identity resourceId '%v' is invalid.It must be of the following format: '/subscriptions/<subid>/resourcegroups/<resourcegroup>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<name>'`, [resourceId])
}
