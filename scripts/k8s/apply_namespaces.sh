#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Creating namespaces..."
kubectl apply -f k8s/namespaces.yaml
