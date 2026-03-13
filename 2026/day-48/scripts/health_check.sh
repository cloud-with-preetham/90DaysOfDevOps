#!/bin/bash

set -e

IMAGE="${DOCKER_USERNAME}/github-actions-capestone:latest"

echo "Pulling latest image..."
docker pull "$IMAGE"

echo "Starting container..."
docker run -d -p 5000:5000 --name health-test "$IMAGE"

echo "Waiting for application to start..."

for i in {1..10}; do
  if curl --silent --fail http://localhost:5000/health; then
    echo "Health check passed"
    docker rm -f health-test
    exit 0
  fi

  echo "Retrying... ($i)"
  sleep 3
done

echo "Health check failed"
docker logs health-test

docker rm -f health-test
exit 1
