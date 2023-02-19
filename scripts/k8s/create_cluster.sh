#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Creating kind cluster..."
kind create cluster --config k8s/kind-config.yaml
