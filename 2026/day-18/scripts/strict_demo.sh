#!/bin/bash

set -euo pipefail

# Test-1: Undefined variables

echo "1) Testing undefined variables (set -u)"
echo "Value is $UNDEFINED_VAR" # This variable is not defined.

echo "This line will NOT run and it stops the above script."

# Test-2: Failing commands

echo "2) Testing failing commands (set -e)"
false

echo "This line will NOT run and it stops the above script."

# Test-3: Pipeline failure

echo "3) Testing pipeline failure (set -o pipefail)"
cat demo_testing.txt | grep "text"

echo "This line will NOT run if any command in pipeline fails."
