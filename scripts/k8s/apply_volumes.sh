#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Creating volume and claim..."
kubectl apply -f k8s/persistentvolume.yaml
kubectl apply -f k8s/persistentvolumeclaim.yaml
