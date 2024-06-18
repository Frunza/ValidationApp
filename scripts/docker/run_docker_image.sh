#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Running docker image..."
docker run -d -p 5555:5555 validation_server_app
