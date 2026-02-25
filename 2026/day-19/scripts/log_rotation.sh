#!/bin/bash

set -euo pipefail

# -----------------------------
# Check argument
# -----------------------------
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

LOG_DIR="$1"

# Exit if directory does not exist
if [[ ! -d "$LOG_DIR" ]]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

echo "Log rotation started for: $LOG_DIR"
echo "-----------------------------------"

# -----------------------------
# Compress .log files older than 7 days
# -----------------------------
compressed_count=0

while IFS= read -r -d '' file; do
    gzip "$file"
    ((compressed_count++))
done < <(find "$LOG_DIR" -type f -name "*.log" -mtime +7 -print0)

# -----------------------------
# Delete .gz files older than 30 days
# -----------------------------
deleted_count=0

while IFS= read -r -d '' file; do
    rm -f "$file"
    ((deleted_count++))
done < <(find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -print0)

# -----------------------------
# Summary
# -----------------------------
echo
echo "Rotation Summary"
echo "----------------"
echo "Compressed files : $compressed_count"
echo "Deleted files    : $deleted_count"
echo "Completed at     : $(date)"
