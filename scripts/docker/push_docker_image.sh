#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Pushing docker image..."
docker push frunzahincu/validation_app
