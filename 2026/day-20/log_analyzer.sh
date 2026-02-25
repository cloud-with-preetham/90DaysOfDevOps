#!/bin/bash

set -euo pipefail

# -----------------------------
# Task 1: Input & Validation
# -----------------------------

# Check argument count
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE="$1"

# Check file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: File '$LOG_FILE' does not exist."
    exit 1
fi

echo "Log file validated successfully: $LOG_FILE"

# -----------------------------
# Task 2: Error Count
# -----------------------------

ERROR_COUNT=$(grep -Eic "ERROR|Failed" "$LOG_FILE" || true)

echo
echo "--- Error Summary ---"
echo "Total ERROR/Failed entries: $ERROR_COUNT"

# -----------------------------
# Task 3: Critical Events
# -----------------------------
echo
echo "--- Critical Events ---"

CRITICAL_EVENTS=$(grep -n "CRITICAL" "$LOG_FILE" || true)

if [[ -n "$CRITICAL_EVENTS" ]]; then
    # Format output nicely
    echo "$CRITICAL_EVENTS" | while IFS=: read -r line content; do
        echo "Line $line: $content"
    done
else
    echo "No critical events found."
fi

# -----------------------------
# Task 4: Top 5 Error Messages
# -----------------------------
echo
echo "--- Top 5 Error Messages ---"

TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" 2>/dev/null \
    | sed -E 's/^[0-9-]+[[:space:]][0-9:]+[[:space:]]+//' \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -5 || true)

if [[ -n "$TOP_ERRORS" ]]; then
    echo "$TOP_ERRORS"
else
    echo "No error messages found."
fi

# -----------------------------
# Task 5: Generate Summary Report
# -----------------------------

DATE=$(date +%Y-%m-%d)
REPORT_FILE="log_report_${DATE}.txt"

TOTAL_LINES=$(wc -l < "$LOG_FILE")

{
echo "===================================="
echo "        LOG ANALYSIS REPORT"
echo "===================================="
echo "Date of Analysis : $(date)"
echo "Log File         : $LOG_FILE"
echo "Total Lines      : $TOTAL_LINES"
echo "Total Errors     : $ERROR_COUNT"

echo
echo "----- Top 5 Error Messages -----"
if [[ -n "${TOP_ERRORS:-}" ]]; then
    echo "$TOP_ERRORS"
else
    echo "None"
fi

echo
echo "----- Critical Events -----"
if [[ -n "${CRITICAL_EVENTS:-}" ]]; then
    echo "$CRITICAL_EVENTS" | while IFS=: read -r line content; do
        echo "Line $line: $content"
    done
else
    echo "None"
fi

} > "$REPORT_FILE"

echo
echo "Report generated: $REPORT_FILE"

# -----------------------------
# Task 6: Archive Processed Log
# -----------------------------

ARCHIVE_DIR="archive"

# Create archive directory if missing
mkdir -p "$ARCHIVE_DIR"

# Move log file
mv "$LOG_FILE" "$ARCHIVE_DIR/"

echo "Log file archived to: $ARCHIVE_DIR/"
