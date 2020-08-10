# OPA Gatekeeper Library
Collection of [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper) constraints templates that can be used in your cluster.

## Get Started
There are two ways to install the constraint templates, either with Helm or Kustomize. Kustomize is probably the easiest method to install the
constraint template but it will require you to copy the constraints. While Helm offers a more managed solution allowing to only install the
constraint templates that are required.

Follow the instruction in one of the two tutorials:
* [Get started with Helm](./charts/gatekeeper-library)
* [Get started with Kustomize](./deploy)

## Development
Read the [Development Guide](./library) for imformation about how to add new constraint templates.

# License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
