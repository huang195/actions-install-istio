#!/bin/sh

if [ -z "$INPUT_KUBECONFIG" ]; then
  echo "KUBECONFIG is expected, exiting..."
  exit 1
fi

mkdir ~/.kube
echo "$INPUT_KUBECONFIG" > ~/.kube/config
kubect get pods --all-namespaces
