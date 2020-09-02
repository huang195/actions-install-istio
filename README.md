Setup Istio Github Action
=========================

Install Istio

## Usage

Istio requires a Kubernetes cluster to run. You can use any Github Actions that installs a Kubernetes cluster before running this action. An example is shown below.

### Basic

```yaml
name: Example workflow
on: [push]
jobs:
  example:
    name: Create Istio service mesh
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v1
      - name: Setup Minikube
        uses: manusa/actions-setup-minikube@v2.0.0
        with:
          minikube version: 'v1.11.0'
          kubernetes version: 'v1.17.7'
          start args: '--embed-certs'
      - name: Get kubeconfig
        id: kubeconfig
        run: a="$(cat ~/.kube/config)"; a="${a//'%'/'%25'}"; a="${a//$'\n'/'%0A'}"; a="${a//$'\r'/'%0D'}"; echo "::set-output name=config::$a"
      - name: Install Istio
        uses: huang195/actions-install-istio@master
        with:
          kubeconfig: "${{steps.kubeconfig.outputs.config}}"
          istio version: '1.6.3'
      - name: Interact with the cluster
        run: kubectl get all --all-namespaces
```

### Required input parameters

| Parameter | Description |
| --------- | ----------- |
| `kubeconfig` | Kubeconfig file that kubectl uses |

### Optional input parameters

| Parameter | Description |
| --------- | ----------- |
| `istio version` | Istio [version](https://github.com/istio/istio/releases) to deploy |
| `istio profile` | Istio profile during installation |
| `istio args` | Istio arguments during installation |

