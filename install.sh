#!/bin/sh

#############################################################
# Check for input parameters
#############################################################

if [ -z "$INPUT_KUBECONFIG" ]; then
  echo "KUBECONFIG input parameter is not set, exiting..."
  exit 1
fi

if [ -z "$INPUT_ISTIO_VERSION" ]; then
  echo "ISTIO_VERSION input parameter is not set, exiting..."
  exit 1
fi


#############################################################
# Create Kubernetes configuration to access the cluster
#############################################################

mkdir ~/.kube
echo "$INPUT_KUBECONFIG" > ~/.kube/config
cat ~/.kube/config


#############################################################
# Sanity check
#############################################################
kubectl get pods --all-namespaces


#############################################################
# Install Istio
#############################################################

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=${INPUT_ISTIO_VERSION} sh -
istio-${INPUT_ISTIO_VERSION}/bin/istioctl version

# Disable Kiali and Grafana as it is non-interactive
istio-${INPUT_ISTIO_VERSION}/bin/istioctl manifest apply --set profile=demo \
--set values.kiali.enabled=false --set values.grafana.enabled=false

# Add a delay here so `kubectl wait` below is gated to Istio pods correctly
#sleep 1

# Wait for all Istio pods to become ready
# TODO: This wait might not be needed 
#kubectl wait --for=condition=Ready pods --all -n istio-system --timeout=60s
kubectl -n istio-system get pods
