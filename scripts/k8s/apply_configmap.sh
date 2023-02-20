#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Creating configmap..."
kubectl apply -f k8s/configmap.yaml
