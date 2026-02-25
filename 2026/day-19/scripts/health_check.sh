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
