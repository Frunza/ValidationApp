#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Building docker image..."
docker build -t validation_server_app .
