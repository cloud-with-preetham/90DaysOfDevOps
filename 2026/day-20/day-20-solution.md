# Day 20 Solution – Bash Scripting Challenge: Log Analyzer and Report Generator

## Overview

This solution implements a comprehensive log analyzer script that processes server log files, identifies errors and critical events, and generates detailed summary reports.

---

## Script Code

### log_analyzer.sh

```bash
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
```

---

## Sample Output

### Console Output

```
Log file validated successfully: zookeeper_2k.log

--- Error Summary ---
Total ERROR/Failed entries: 305

--- Critical Events ---
No critical events found.

--- Top 5 Error Messages ---
      1 2015-07-29 23:44:28,903 - ERROR [CommitProcessor:1:NIOServerCnxn@180] - Unexpected Exception:
      1 2015-07-29 19:21:26,625 - ERROR [LearnerHandler-/10.10.34.11:52855:LearnerHandler@562] - Unexpected exception causing shutdown while sock still open
      1 2015-07-29 19:20:56,605 - ERROR [LearnerHandler-/10.10.34.11:52814:LearnerHandler@562] - Unexpected exception causing shutdown while sock still open
      1 2015-07-29 19:20:46,814 - ERROR [LearnerHandler-/10.10.34.13:57617:LearnerHandler@562] - Unexpected exception causing shutdown while sock still open
      1 2015-07-29 19:20:36,704 - ERROR [LearnerHandler-/10.10.34.12:59480:LearnerHandler@562] - Unexpected exception causing shutdown while sock still open

Report generated: log_report_2026-02-25.txt
Log file archived to: archive/
```

### Generated Report (log_report_2026-02-25.txt)

```
====================================
        LOG ANALYSIS REPORT
====================================
Date of Analysis : Wed Feb 25 09:29:05 UTC 2026
Log File         : zookeeper_2k.log
Total Lines      : 2000
Total Errors     : 305

----- Top 5 Error Messages -----
      1 2015-07-29 23:44:28,903 - ERROR [CommitProcessor:1:NIOServerCnxn@180] - Unexpected Exception:
      1 2015-07-29 19:21:26,625 - ERROR [LearnerHandler-/10.10.34.11:52855:LearnerHandler@562] - Unexpected exception causing shutdown while sock still open
      1 2015-07-29 19:20:56,605 - ERROR [LearnerHandler-/10.10.34.11:52814:LearnerHandler@562] - Unexpected exception causing shutdown while sock still open
      1 2015-07-29 19:20:46,814 - ERROR [LearnerHandler-/10.10.34.13:57617:LearnerHandler@562] - Unexpected exception causing shutdown while sock still open
      1 2015-07-29 19:20:36,704 - ERROR [LearnerHandler-/10.10.34.12:59480:LearnerHandler@562] - Unexpected exception causing shutdown while sock still open

----- Critical Events -----
None
```

---

## Commands and Tools Used

### 1. **grep** - Pattern Matching

- `grep -Eic "ERROR|Failed"` - Case-insensitive count of ERROR or Failed
- `grep -n "CRITICAL"` - Search with line numbers
- Used for filtering log entries based on keywords

### 2. **sed** - Stream Editor

- `sed -E 's/^[0-9-]+[[:space:]][0-9:]+[[:space:]]+//'` - Remove timestamps from log lines
- Used for text transformation and cleanup

### 3. **sort** - Sorting Lines

- `sort` - Alphabetically sort lines
- `sort -rn` - Reverse numeric sort
- Used for organizing data before counting

### 4. **uniq** - Remove Duplicates

- `uniq -c` - Count unique occurrences
- Must be used with sorted input

### 5. **head** - Display First Lines

- `head -5` - Show top 5 results
- Used for limiting output to most frequent errors

### 6. **wc** - Word Count

- `wc -l` - Count total lines in file
- Used for statistics gathering

### 7. **date** - Date/Time Operations

- `date +%Y-%m-%d` - Format date for filename
- Used for timestamping reports

### 8. **Bash Features**

- `set -euo pipefail` - Strict error handling
- `[[ ]]` - Advanced conditional testing
- `$( )` - Command substitution
- `|| true` - Prevent script exit on grep no-match

---

## Key Learnings

### 1. **Robust Error Handling**

Using `set -euo pipefail` ensures the script fails fast on errors. The `|| true` pattern prevents grep from causing script termination when no matches are found, which is critical for production scripts.

### 2. **Text Processing Pipeline**

Combining grep, sed, sort, uniq, and head creates powerful data processing pipelines. The order matters: sort before uniq, and use sed to normalize data before counting occurrences.

### 3. **Production-Ready Scripting**

Real-world log analysis requires input validation, graceful handling of edge cases (no errors found, missing files), and clear user feedback. Archiving processed logs prevents reprocessing and maintains audit trails.

---

## Usage

```bash
# Make script executable
chmod +x log_analyzer.sh

# Run the analyzer
./log_analyzer.sh zookeeper_2k.log

# Check the generated report
cat log_report_2026-02-25.txt

# Verify archived log
ls archive/
```

---

## Project Structure

```
day-20/
├── log_analyzer.sh              # Main script
├── log_report_2026-02-25.txt    # Generated report
├── archive/                      # Archived logs
│   └── zookeeper_2k.log
├── screenshots/                  # Task screenshots
└── day-20-solution.md           # This documentation
```

---

## Conclusion

This log analyzer successfully automates the tedious task of manual log analysis, providing system administrators with quick insights into server health, error patterns, and critical events. The script is production-ready with proper error handling, validation, and archival capabilities.
