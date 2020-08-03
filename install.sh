#!/bin/sh

if [ -z $KUBECONFIG ]; then
  echo "KUBECONFIG is expected, exiting..."
  exit 1
fi

mkdir ~/.kube
echo "$KUBECONFIG" > ~/.kube/config
