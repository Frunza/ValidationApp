#!/bin/bash

# Exit immediately if a simple command exits with a nonzero exit value
set -e

echo "Start server..."
python3 src/server.py
