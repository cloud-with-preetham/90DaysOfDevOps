#!/bin/bash

# Strict mode
set -euo pipefail

# -----------------------------
# Validate arguments
# -----------------------------
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    exit 1
fi

SOURCE_DIR="$1"
DEST_DIR="$2"

# -----------------------------
# Validate source directory
# -----------------------------
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

# Create destination if missing
mkdir -p "$DEST_DIR"

# -----------------------------
# Create timestamped archive
# -----------------------------
TIMESTAMP=$(date +"%Y-%m-%d")
ARCHIVE_NAME="backup-${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${DEST_DIR}/${ARCHIVE_NAME}"

echo "Creating backup..."
echo "Source      : $SOURCE_DIR"
echo "Destination : $ARCHIVE_PATH"

tar -czf "$ARCHIVE_PATH" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

# -----------------------------
# Verify archive creation
# -----------------------------
if [[ ! -f "$ARCHIVE_PATH" ]]; then
    echo "Error: Backup archive was not created."
    exit 1
fi

# Get archive size
ARCHIVE_SIZE=$(du -h "$ARCHIVE_PATH" | awk '{print $1}')

echo
echo "Backup created successfully!"
echo "Archive : $ARCHIVE_NAME"
echo "Size    : $ARCHIVE_SIZE"

# -----------------------------
# Delete backups older than 14 days
# -----------------------------
echo
echo "Cleaning old backups (>14 days)..."

DELETED_COUNT=0

while IFS= read -r -d '' file; do
    rm -f "$file"
    ((DELETED_COUNT++))
done < <(find "$DEST_DIR" -type f -name "backup-*.tar.gz" -mtime +14 -print0)

echo "Old backups deleted: $DELETED_COUNT"

echo
echo "Backup completed at: $(date)"
