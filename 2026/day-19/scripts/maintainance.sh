#!/bin/bash

set -euo pipefail

# -----------------------------
# Configuration
# -----------------------------
LOG_ROTATE_SCRIPT="/home/ubuntu/90DaysOfDevOps/2026/day-19/scripts/log_rotation.sh"
BACKUP_SCRIPT="/home/ubuntu/90DaysOfDevOps/2026/day-19/scripts/backup.sh"

LOG_DIR="/var/log/myapp"
BACKUP_SOURCE="/home/ubuntu/90DaysOfDevOps/2026/day-19/data"
BACKUP_DEST="/home/ubuntu/90DaysOfDevOps/2026/day-19/backups"

LOG_FILE="/var/log/maintenance.log"

# -----------------------------
# Logging function
# -----------------------------
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Redirect ALL output to log file
exec >> "$LOG_FILE" 2>&1

log "========== Maintenance Started =========="

# -----------------------------
# Run Log Rotation
# -----------------------------
log "Running log rotation..."
"$LOG_ROTATE_SCRIPT" "$LOG_DIR"
log "Log rotation completed."

# -----------------------------
# Run Backup
# -----------------------------
log "Running backup..."
"$BACKUP_SCRIPT" "$BACKUP_SOURCE" "$BACKUP_DEST"
log "Backup completed."

log "========== Maintenance Finished =========="
echo
