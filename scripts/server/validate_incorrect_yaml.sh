#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Validating yaml..."
curl -X POST 'localhost:5555/validate-yaml' --header 'Content-Type: text/plain' --data-binary '@tests/incorrect_yaml_example'