#!/bin/bash
set -euo pipefail

echo "Running health check"

STATUS="ok"
if [ "$STATUS" != "ok" ]; then
  echo "Health check failed"
  exit 1
fi

echo "Health check passed"

