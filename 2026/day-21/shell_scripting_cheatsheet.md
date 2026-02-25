# Shell Scripting Cheat Sheet

## Quick Reference Table

| Topic | Key Syntax | Example |
|-------|-----------|---------|
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Argument | `$1`, `$2` | `./script.sh arg1` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For loop | `for i in list; do` | `for i in 1 2 3; do` |
| Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -i "error" log.txt` |
| Awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |

---

## Task 1: Basics

### 1. Shebang
Tells the system which interpreter to use for executing the script.

```bash
#!/bin/bash
```

### 2. Running a Script

```bash
# Make executable
chmod +x script.sh # (best practice -> chmod 764 script.sh)
# 7 -> read, write, execute = owner
# 6 -> read, write = group
# 4 -> read only = others

# Run with ./
./script.sh

# Run with bash
bash script.sh
```

### 3. Comments

```bash
# This is a single-line comment
<<task
This is a multi-line comment
task
echo "Hello" # This is an inline comment
```

### 4. Variables

```bash
# Declaring
NAME="DevOps"

# Using
echo $NAME
echo "$NAME"    # Expands variable
echo '$NAME'    # Literal string, no expansion
```

### 5. Reading User Input

```bash
read -p "Enter your name: " username
echo "Hello, $username"
```

### 6. Command-line Arguments

```bash
$0  # Script name
$1  # First argument
$2  # Second argument
$#  # Number of arguments
$@  # All arguments as separate words
$?  # Exit status of last command
```

---

## Task 2: Operators and Conditionals

### 1. String Comparisons

```bash
[ "$str1" = "$str2" ]   # Equal
[ "$str1" != "$str2" ]  # Not equal
[ -z "$str" ]           # Empty string
[ -n "$str" ]           # Non-empty string
```

### 2. Integer Comparisons

```bash
[ $a -eq $b ]  # Equal
[ $a -ne $b ]  # Not equal
[ $a -lt $b ]  # Less than
[ $a -gt $b ]  # Greater than
[ $a -le $b ]  # Less than or equal
[ $a -ge $b ]  # Greater than or equal
```

### 3. File Test Operators

```bash
[ -f file ]  # Is a regular file
[ -d dir ]   # Is a directory
[ -e path ]  # Exists
[ -r file ]  # Readable
[ -w file ]  # Writable
[ -x file ]  # Executable
[ -s file ]  # Not empty
```

### 4. If-Elif-Else Syntax

```bash
if [ condition ]; then
    echo "Condition is true"
elif [ other_condition ]; then
    echo "Other condition is true"
else
    echo "All conditions false"
fi
```

### 5. Logical Operators

```bash
[ condition1 ] && [ condition2 ]  # AND
[ condition1 ] || [ condition2 ]  # OR
[ ! condition ]                   # NOT

# Alternative
if [ condition1 ] && [ condition2 ]; then
    echo "Both true"
fi
```

### 6. Case Statements

```bash
case $variable in
    pattern1)
        echo "Matched pattern1"
        ;;
    pattern2|pattern3)
        echo "Matched pattern2 or pattern3"
        ;;
    *)
        echo "Default case"
        ;;
esac
```

---

## Task 3: Loops

### 1. For Loop

```bash
# List-based
for item in apple banana cherry; do
    echo $item
done

# C-style
for ((i=0; i<5; i++)); do
    echo $i
done
```

### 2. While Loop

```bash
count=0
while [ $count -lt 5 ]; do
    echo $count
    ((count++))
done
```

### 3. Until Loop

```bash
count=0
until [ $count -ge 5 ]; do
    echo $count
    ((count++))
done
```

### 4. Loop Control

```bash
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        continue  # Skip iteration
    fi
    if [ $i -eq 8 ]; then
        break     # Exit loop
    fi
    echo $i
done
```

### 5. Looping Over Files

```bash
for file in *.log; do
    echo "Processing $file"
done
```

### 6. Looping Over Command Output

```bash
while read line; do
    echo "Line: $line"
done < file.txt

# Or from command
ls -1 | while read file; do
    echo "File: $file"
done
```

---

## Task 4: Functions

### 1. Defining a Function

```bash
function_name() {
    echo "This is a function"
}

# Alternative syntax
function function_name {
    echo "This is a function"
}
```

### 2. Calling a Function

```bash
function_name
```

### 3. Passing Arguments to Functions

```bash
greet() {
    echo "Hello, $1!"
    echo "You are $2 years old"
}

greet "Alice" 25
```

### 4. Return Values

```bash
# Using return (exit code 0-255)
check_file() {
    if [ -f "$1" ]; then
        return 0
    else
        return 1
    fi
}

# Using echo (for strings/values)
get_name() {
    echo "DevOps"
}

result=$(get_name)
```

### 5. Local Variables

```bash
my_function() {
    local var="Local scope"
    echo $var
}
```

---

## Task 5: Text Processing Commands

### 1. grep - Search Patterns

```bash
grep "pattern" file.txt          # Basic search
grep -i "pattern" file.txt       # Case-insensitive
grep -r "pattern" /path          # Recursive
grep -c "pattern" file.txt       # Count matches
grep -n "pattern" file.txt       # Show line numbers
grep -v "pattern" file.txt       # Invert match
grep -E "pat1|pat2" file.txt     # Extended regex
```

### 2. awk - Pattern Scanning and Processing

```bash
awk '{print $1}' file.txt                    # Print first column
awk -F: '{print $1}' /etc/passwd             # Custom delimiter
awk '/pattern/ {print $2}' file.txt          # Pattern matching
awk 'BEGIN {sum=0} {sum+=$1} END {print sum}' file.txt
```

### 3. sed - Stream Editor

```bash
sed 's/old/new/' file.txt        # Replace first occurrence
sed 's/old/new/g' file.txt       # Replace all occurrences
sed -i 's/old/new/g' file.txt    # In-place edit
sed '5d' file.txt                # Delete line 5
sed '/pattern/d' file.txt        # Delete matching lines
```

### 4. cut - Extract Columns

```bash
cut -d: -f1 /etc/passwd          # Extract first field
cut -c1-10 file.txt              # Extract characters 1-10
cut -d, -f2,4 file.csv           # Extract fields 2 and 4
```

### 5. sort - Sort Lines

```bash
sort file.txt                    # Alphabetical sort
sort -n file.txt                 # Numerical sort
sort -r file.txt                 # Reverse sort
sort -u file.txt                 # Unique sort
sort -k2 file.txt                # Sort by 2nd column
```

### 6. uniq - Remove Duplicates

```bash
uniq file.txt                    # Remove adjacent duplicates
uniq -c file.txt                 # Count occurrences
uniq -d file.txt                 # Show only duplicates
sort file.txt | uniq             # Remove all duplicates
```

### 7. tr - Translate/Delete Characters

```bash
tr 'a-z' 'A-Z' < file.txt        # Lowercase to uppercase
tr -d '0-9' < file.txt           # Delete digits
tr -s ' ' < file.txt             # Squeeze spaces
```

### 8. wc - Count Lines/Words/Characters

```bash
wc -l file.txt                   # Count lines
wc -w file.txt                   # Count words
wc -c file.txt                   # Count bytes
wc -m file.txt                   # Count characters
```

### 9. head / tail - First/Last Lines

```bash
head -n 10 file.txt              # First 10 lines
tail -n 10 file.txt              # Last 10 lines
tail -f file.txt                 # Follow mode (live updates)
tail -f file.txt | grep ERROR    # Follow and filter
```

---

## Task 6: Useful Patterns and One-Liners

### 1. Find and Delete Files Older Than N Days

```bash
find /path -type f -mtime +30 -delete
```

### 2. Count Lines in All .log Files

```bash
wc -l *.log
# Or total only
cat *.log | wc -l
```

### 3. Replace String Across Multiple Files

```bash
sed -i 's/old_string/new_string/g' *.txt
# Or with find
find . -type f -name "*.txt" -exec sed -i 's/old/new/g' {} +
```

### 4. Check if a Service is Running

```bash
systemctl is-active --quiet service_name && echo "Running" || echo "Not running"
# Or
ps aux | grep -v grep | grep service_name
```

### 5. Monitor Disk Usage with Alerts

```bash
df -h | awk '$5+0 > 80 {print "Alert: " $0}'
```

### 6. Parse CSV Column

```bash
awk -F, '{print $2}' data.csv
```

### 7. Tail Log and Filter Errors in Real Time

```bash
tail -f /var/log/app.log | grep -i error
```

### 8. Find Top 10 Largest Files

```bash
find . -type f -exec du -h {} + | sort -rh | head -n 10
```

### 9. Kill All Processes by Name

```bash
pkill -f process_name
```

### 10. Archive and Compress Directory

```bash
tar -czf backup_$(date +%Y%m%d).tar.gz /path/to/directory
```

---

## Task 7: Error Handling and Debugging

### 1. Exit Codes

```bash
command
echo $?        # 0 = success, non-zero = error

exit 0         # Exit with success
exit 1         # Exit with error
```

### 2. set -e - Exit on Error

```bash
#!/bin/bash
set -e         # Script exits if any command fails

command1
command2       # If this fails, script stops
command3
```

### 3. set -u - Treat Unset Variables as Error

```bash
#!/bin/bash
set -u         # Error if using undefined variable

echo $UNDEFINED_VAR  # This will cause error
```

### 4. set -o pipefail - Catch Errors in Pipes

```bash
#!/bin/bash
set -o pipefail

# Without pipefail, only last command's exit code matters
command1 | command2 | command3
```

### 5. set -x - Debug Mode

```bash
#!/bin/bash
set -x         # Print each command before execution

echo "Debug mode on"
```

### 6. Trap - Cleanup on Exit

```bash
#!/bin/bash

cleanup() {
    echo "Cleaning up..."
    rm -f /tmp/tempfile
}

trap cleanup EXIT

# Script continues...
```

### Combined Best Practice

```bash
#!/bin/bash
set -euo pipefail

trap 'echo "Error on line $LINENO"' ERR
```

---

## Additional Tips

### Arithmetic Operations

```bash
result=$((5 + 3))
((count++))
let "result = 5 * 3"
```

### String Manipulation

```bash
${#string}              # Length
${string:0:5}           # Substring
${string/old/new}       # Replace first
${string//old/new}      # Replace all
${string^^}             # Uppercase
${string,,}             # Lowercase
```

### Arrays

```bash
arr=(one two three)
echo ${arr[0]}          # First element
echo ${arr[@]}          # All elements
echo ${#arr[@]}         # Array length
```

### Redirections

```bash
command > file          # Redirect stdout
command 2> file         # Redirect stderr
command &> file         # Redirect both
command >> file         # Append stdout
command < file          # Input from file
```

---

**Created for #90DaysOfDevOps Challenge**
*Keep this handy for your DevOps journey!*
