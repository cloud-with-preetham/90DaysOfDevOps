# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab

## Overview

This project demonstrates practical shell scripting skills by implementing automated log rotation, server backup, and scheduled maintenance tasks using bash scripts and crontab.

---

## Task 1: Log Rotation Script

### Script: `log_rotation.sh`

```bash
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
```

### Sample Output

```
Log rotation started for: /var/log/myapp
-----------------------------------

Rotation Summary
----------------
Compressed files : 3
Deleted files    : 2
Completed at     : Tue Feb 25 10:30:45 UTC 2026
```

### Features

- ✅ Takes log directory as argument
- ✅ Compresses `.log` files older than 7 days using gzip
- ✅ Deletes `.gz` files older than 30 days
- ✅ Prints compression and deletion counts
- ✅ Exits with error if directory doesn't exist
- ✅ Uses strict mode (`set -euo pipefail`)

---

## Task 2: Server Backup Script

### Script: `backup.sh`

```bash
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
```

### Sample Output

```
Creating backup...
Source      : /home/ubuntu/90DaysOfDevOps/2026/day-19/data
Destination : /home/ubuntu/90DaysOfDevOps/2026/day-19/backups/backup-2026-02-25.tar.gz

Backup created successfully!
Archive : backup-2026-02-25.tar.gz
Size    : 4.0K

Cleaning old backups (>14 days)...
Old backups deleted: 0

Backup completed at: Tue Feb 25 10:35:22 UTC 2026
```

### Features

- ✅ Takes source directory and backup destination as arguments
- ✅ Creates timestamped `.tar.gz` archive
- ✅ Verifies archive was created successfully
- ✅ Prints archive name and size
- ✅ Deletes backups older than 14 days
- ✅ Handles errors with proper exit codes

---

## Task 3: Crontab Scheduling

### Understanding Cron Syntax

```
* * * * *  command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7, where 0 and 7 are Sunday)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

### Cron Entries

#### 1. Run `log_rotate.sh` every day at 2 AM

```cron
0 2 * * * /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/day-19/scripts/log_rotation.sh /var/log/myapp
```

#### 2. Run `backup.sh` every Sunday at 3 AM

```cron
0 3 * * 0 /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/day-19/scripts/backup.sh /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/day-19/data /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/day-19/backups
```

#### 3. Run health check script every 5 minutes

```cron
*/5 * * * * /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/day-19/scripts/health_check.sh
```

### How to Apply Cron Jobs

```bash
# View current crontab
crontab -l

# Edit crontab
crontab -e

# Add the above entries to your crontab file
```

---

## Task 4: Scheduled Maintenance Script

### Script: `maintainance.sh`

```bash
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
```

### Cron Entry for Maintenance Script

Run maintenance script daily at 1 AM:

```cron
0 1 * * * /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/2026/day-19/scripts/maintainance.sh
```

### Sample Log Output (`/var/log/maintenance.log`)

```
[2026-02-25 01:00:01] ========== Maintenance Started ==========
[2026-02-25 01:00:01] Running log rotation...
Log rotation started for: /var/log/myapp
-----------------------------------

Rotation Summary
----------------
Compressed files : 3
Deleted files    : 1
Completed at     : Tue Feb 25 01:00:02 UTC 2026
[2026-02-25 01:00:02] Log rotation completed.
[2026-02-25 01:00:02] Running backup...
Creating backup...
Source      : /home/ubuntu/90DaysOfDevOps/2026/day-19/data
Destination : /home/ubuntu/90DaysOfDevOps/2026/day-19/backups/backup-2026-02-25.tar.gz

Backup created successfully!
Archive : backup-2026-02-25.tar.gz
Size    : 4.0K

Cleaning old backups (>14 days)...
Old backups deleted: 0

Backup completed at: Tue Feb 25 01:00:03 UTC 2026
[2026-02-25 01:00:03] Backup completed.
[2026-02-25 01:00:03] ========== Maintenance Finished ==========
```

---

## Bonus: Health Check Script

### Script: `health_check.sh`

```bash
#!/bin/bash

set -euo pipefail

echo "================================="
echo "SYSTEM HEALTH CHECK"
echo "Time: $(date)"
echo "================================="

# -----------------------------
# CPU Load
# -----------------------------
echo
echo "[CPU LOAD]"
uptime

# -----------------------------
# Memory Usage
# -----------------------------
echo
echo "[MEMORY USAGE]"
free -h

# -----------------------------
# Disk Usage (warn if >80%)
# -----------------------------
echo
echo "[DISK USAGE]"
df -h | awk 'NR>=0&&NR<=2 || $5+0 >= 80 {print}'

# -----------------------------
# Check important process
# (example: ssh service)
# -----------------------------
echo
echo "[SERVICE CHECK - SSH]"

if pgrep -x "sshd" > /dev/null; then
    echo "SSH service is running"
else
    echo "SSH service is NOT running"
fi

echo
echo "Health check completed."
```

### Sample Output

```
=================================
SYSTEM HEALTH CHECK
Time: Tue Feb 25 10:40:15 UTC 2026
=================================

[CPU LOAD]
 10:40:15 up 5 days,  3:22,  1 user,  load average: 0.15, 0.10, 0.08

[MEMORY USAGE]
              total        used        free      shared  buff/cache   available
Mem:           7.7G        2.1G        4.2G         12M        1.4G        5.3G
Swap:          2.0G          0B        2.0G

[DISK USAGE]
Filesystem      Size  Used Avail Use% Mounted on
/dev/xvda1       30G   12G   18G  40% /

[SERVICE CHECK - SSH]
SSH service is running

Health check completed.
```

---

## Complete Crontab Configuration

Here's the complete crontab configuration for all scripts:

```cron
# Run maintenance script daily at 1 AM
0 1 * * * /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/2026/day-19/scripts/maintainance.sh

# Run log rotation every day at 2 AM
0 2 * * * /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/2026/day-19/scripts/log_rotation.sh /var/log/myapp

# Run backup every Sunday at 3 AM
0 3 * * 0 /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/2026/day-19/scripts/backup.sh /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/day-19/data /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/day-19/backups

# Run health check every 5 minutes
*/5 * * * * /home/ubuntu/Train-with-Shubham/90DaysOfDevOps/2026/day-19/scripts/health_check.sh >> /var/log/health_check.log 2>&1
```

---

## Key Learnings

### 1. **Robust Error Handling with `set -euo pipefail`**

Using strict mode in bash scripts ensures that:

- `set -e`: Script exits immediately if any command fails
- `set -u`: Script exits if an undefined variable is used
- `set -o pipefail`: Pipeline fails if any command in the pipeline fails

This prevents silent failures and makes scripts more reliable in production environments.

### 2. **Safe File Processing with Null Delimiters**

Using `find` with `-print0` and `read -d ''` handles filenames with spaces, newlines, or special characters safely:

```bash
while IFS= read -r -d '' file; do
    # Process file
done < <(find "$DIR" -name "*.log" -print0)
```

This is more robust than using `for` loops with command substitution.

### 3. **Automated Scheduling with Crontab**

Crontab enables unattended automation of maintenance tasks:

- Reduces manual intervention and human error
- Ensures consistent execution at specified times
- Centralizes scheduled task management
- Logs can be redirected for monitoring and debugging

Understanding cron syntax and proper path specification (absolute paths) is crucial for reliable automation.

---

## Project Structure

```
day-19/
├── scripts/
│   ├── log_rotation.sh      # Compresses old logs, deletes ancient archives
│   ├── backup.sh            # Creates timestamped backups, cleans old ones
│   ├── health_check.sh      # System health monitoring
│   └── maintainance.sh      # Orchestrates log rotation and backup
├── data/                    # Sample data directory for backup testing
├── backups/                 # Backup destination directory
├── screenshots/             # Documentation screenshots
├── README.md               # Project requirements
└── day-19-project.md       # This documentation file
```

---

## Testing Commands

```bash
# Make scripts executable
chmod +x scripts/*.sh

# Test log rotation
./scripts/log_rotation.sh /var/log/myapp

# Test backup
./scripts/backup.sh ./data ./backups

# Test health check
./scripts/health_check.sh

# Test maintenance script
./scripts/maintainance.sh

# View maintenance log
cat /var/log/maintenance.log
```

---

## Conclusion

This project successfully demonstrates:

- Automated log rotation with compression and cleanup
- Timestamped backup creation with verification
- System health monitoring
- Scheduled task automation using crontab
- Proper error handling and logging
- Production-ready bash scripting practices

These scripts form the foundation of automated system maintenance and can be extended for more complex DevOps workflows.
