#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Tagging docker image..."
docker tag validation_server_app frunzahincu/validation_app
