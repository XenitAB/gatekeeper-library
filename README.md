# OPA Gatekeeper Library

Collection of [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper) policies that can be used in your Kubernetes cluster.

## Prerequisites

This project assumes that you have the latest version of Gatekeeper installed, including the CRDs.

## Get Started

There are two ways to install the policies, either with Helm or Kustomize. Kustomize is probably the easiest method to install the
policies but it will require you to write your own constraints from scratch. While Helm offers a streamlined solution by implementing
sane default values for most parameters.

Follow the instruction in one of the two tutorials:

- [Get started with Helm](./charts)
- [Get started with Kustomize](./deploy)

## Development

Read the [Development Guide](./library) for information about how to add new policies.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
