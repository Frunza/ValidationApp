#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Removing application docker container..."
docker rm $(docker stop $(docker ps -a -q --filter ancestor="validation_server_app"))
