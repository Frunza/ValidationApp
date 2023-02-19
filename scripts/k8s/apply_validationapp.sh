#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Aplying the app deployment..."
kubectl apply -f k8s/validationapp_deployment.yaml
