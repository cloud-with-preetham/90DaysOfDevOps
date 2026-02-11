#!/bin/bash

set -euo pipefail

echo "Strict mode enabled"
# This is to check the undefined variable (set -u)
echo $UNDEFINED_VAR

# This is to check the failing command (set -e)
false

# This is to check if pipeline fails (set -o pipeline)
grep "text" non_existing_file |wc -l

echo "Script completed"


