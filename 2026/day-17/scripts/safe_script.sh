#!/bin/bash

set -e

echo "Starting safe script..."

mkdir -p /tmp/devops-test || { echo "Directory not created..."; exit 1; }

cd /tmp/devops-test || { echo "Unable to change the directory..."; exit 1; }

touch test-file.txt || { echo "File was not created..."; exit 1; }

echo "File created successfully in /tmp/devops-test"
