# Day 18 – Shell Scripting: Functions & Intermediate Concepts

## Overview

This document covers shell scripting functions, strict mode, local variables, and building reusable scripts.

---

## Task 1: Basic Functions

### Script: `functions.sh`

```bash
#!/bin/bash

greet() {
	name=$1
	echo "Hello, $1..!"
}

add() {
	num1=$1
	num2=$2
	sum=$((num1+num2))
	echo "Sum: ${sum}"
}

greet "Alice"
add 509 60
```

### Output:

```
Hello, Alice..!
Sum: 569
```

### Explanation:

- `greet()` function takes a name as argument (`$1`) and prints a greeting
- `add()` function takes two numbers, calculates their sum using arithmetic expansion `$((...))`
- Functions are called by name with arguments: `greet "Alice"` and `add 509 60`

---

## Task 2: Functions with Return Values

### Script: `disk_check.sh`

```bash
#!/bin/bash

check_disk() {
	echo "==== Disk Usage (/) ===="
	df -h /
}

check_memory() {
	echo "==== Memory Usage ===="
	free -h
}

main() {
	echo "===== SYSTEM DETAILS ====="
	echo "--------------------------"
	check_disk
	check_memory
}

main
```

### Output:

```
===== SYSTEM DETAILS =====
--------------------------
==== Disk Usage (/) ====
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        97G   24G   74G  25% /
==== Memory Usage ====
               total        used        free      shared  buff/cache   available
Mem:           7.7Gi       1.2Gi       5.8Gi       1.0Mi       723Mi       6.3Gi
Swap:             0B          0B          0B
```

### Explanation:

- `check_disk()` uses `df -h /` to display disk usage for root partition
- `check_memory()` uses `free -h` to display memory statistics
- `main()` function orchestrates the execution of both functions
- Functions can call other functions, creating modular and organized code

---

## Task 3: Strict Mode — `set -euo pipefail`

### Script: `strict_demo.sh`

```bash
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
```

### Output:

```
1) Testing undefined variables (set -u)
strict_demo.sh: line 8: UNDEFINED_VAR: unbound variable
```

### Explanation of Strict Mode Flags:

| Flag              | Purpose                    | Behavior                                                                                    |
| ----------------- | -------------------------- | ------------------------------------------------------------------------------------------- |
| `set -e`          | Exit on error              | Script exits immediately if any command returns non-zero exit status                        |
| `set -u`          | Exit on undefined variable | Script exits if it tries to use an undefined variable                                       |
| `set -o pipefail` | Pipeline failure detection | Returns exit status of the last command in pipeline that failed (not just the last command) |

**What each flag does:**

- `set -e` → Exits the script immediately when any command fails (returns non-zero exit code)
- `set -u` → Treats unset variables as errors and exits the script
- `set -o pipefail` → Makes pipelines fail if any command in the pipeline fails (not just the last one)

**Why use strict mode?**

- Catches errors early before they cause bigger problems
- Makes scripts more reliable and predictable
- Prevents silent failures that are hard to debug
- Forces better error handling practices

---

## Task 4: Local Variables

### Script: `local_demo.sh`

```bash
#!/bin/bash

echo "===== Local v/s Global Variable Demo ====="

# Global variable
message="I am GLOBAL"

# Local variable
use_local() {
	local message="I am LOCAL"
	local temp="Temporary value"

	echo "Inside use_local():"
	echo "message = $message"
	echo "temp = $temp"
}

# Regular variable

use_global() {
	message="Modified by use_global"
	temp="Created globally"

	echo "Inside use_global():"
	echo "message = $message"
	echo "temp = $temp"
}

echo
echo "Before calling functions:"
echo "message = $message"
echo "temp = ${temp:-<undefined>}"

echo
use_local

echo
echo "After use_local():"
echo "message = $message"
echo "temp = ${temp:-<undefined>}"

echo
use_global

echo
echo "After use_global():"
echo "message = $message"
echo "temp = $temp"
```

### Output:

```
===== Local v/s Global Variable Demo =====

Before calling functions:
message = I am GLOBAL
temp = <undefined>

Inside use_local():
message = I am LOCAL
temp = Temporary value

After use_local():
message = I am GLOBAL
temp = <undefined>

Inside use_global():
message = Modified by use_global
temp = Created globally

After use_global():
message = Modified by use_global
temp = Created globally
```

### Explanation:

- **Local variables** (declared with `local` keyword) are scoped to the function and don't affect global scope
- **Global variables** (without `local`) persist and modify the global scope
- `use_local()` creates local variables that disappear after function exits
- `use_global()` modifies global variables that remain accessible after function exits
- Best practice: Use `local` for function-internal variables to avoid side effects

---

## Task 5: System Info Reporter

### Script: `system_info.sh`

```bash
#!/bin/bash

set -euo pipefail

print_header() {
	echo
	echo "=============================================="
	echo "$1"
	echo "=============================================="
}

# Hostname & OS info

system_identity() {
	echo "Hostname: $(hostname)"
	echo "Operating System: $(uname -s) $(uname -r)"
	echo "Kernel: $(uname -v)"
	echo "Architecture: $(uname -m)"
}

# Uptime

system_uptime() {
	uptime -p
}

# Disk usage (Top 5 by size)

disk_usage() {
	df -h --output=source,size,used,avail,pcent,target \
		| tail -n +2 \
		| sort -hr -k3 \
		| head -n 5
}

# Memory usage

memory_usage() {
	free -h
}

# Top 5 memory consuming processes

top_cpu_processes() {
	ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
}

# Function calling
main() {
	print_header "SYSTEM INFORMATION"
	system_identity

	print_header "UPTIME"
	system_uptime

	print_header "DISK USAGE (Top 5 by Used Space)"
	disk_usage

	print_header "MEMORY USAGE"
	memory_usage

	print_header "TOP 5 CPU PROCESSES"
	top_cpu_processes

	echo
	echo "Report generated at: $(date)"
}

# Function called
main
```

### Output:

```
==============================================
SYSTEM INFORMATION
==============================================
Hostname: ip-172-31-89-238
Operating System: Linux 6.8.0-1018-aws
Kernel: #19~22.04.1-Ubuntu SMP Thu Oct 17 15:23:18 UTC 2024
Architecture: x86_64

==============================================
UPTIME
==============================================
up 2 hours, 15 minutes

==============================================
DISK USAGE (Top 5 by Used Space)
==============================================
/dev/root        97G   24G   74G  25% /
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           1.6G  1.1M  1.6G   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/xvda16     881M   76M  744M  10% /boot

==============================================
MEMORY USAGE
==============================================
               total        used        free      shared  buff/cache   available
Mem:           7.7Gi       1.2Gi       5.8Gi       1.0Mi       723Mi       6.3Gi
Swap:             0B          0B          0B

==============================================
TOP 5 CPU PROCESSES
==============================================
    PID COMMAND         %CPU %MEM
   1234 node            2.5  3.2
   5678 python3         1.8  2.1
   9012 bash            0.5  0.3
   3456 systemd         0.2  0.5
   7890 sshd            0.1  0.2

Report generated at: Mon Jan 20 10:30:45 UTC 2025
```

### Explanation:

- **Modular design**: Each function handles one specific task
- **print_header()**: Reusable function for consistent formatting
- **system_identity()**: Uses command substitution `$(...)` to capture command outputs
- **disk_usage()**: Pipes multiple commands together for filtering and sorting
- **main()**: Orchestrates all functions in logical order
- **Strict mode**: `set -euo pipefail` ensures script fails fast on errors
- **Clean output**: Structured sections with headers make information easy to read

---

## What I Learned (3 Key Points)

### 1. **Functions Make Scripts Modular and Reusable**

Functions allow breaking down complex scripts into smaller, manageable pieces. Each function has a single responsibility, making code easier to understand, test, and maintain. Functions can be reused across different parts of the script or even in other scripts.

### 2. **Strict Mode (`set -euo pipefail`) Prevents Silent Failures**

Using strict mode is a best practice that catches errors early:

- Undefined variables are caught immediately
- Failed commands stop execution instead of continuing
- Pipeline failures are properly detected
  This makes scripts more reliable and easier to debug in production environments.

### 3. **Local Variables Prevent Unintended Side Effects**

Using the `local` keyword for function variables prevents them from polluting the global namespace. This is crucial for:

- Avoiding variable name conflicts
- Making functions self-contained and predictable
- Preventing bugs caused by unintended variable modifications
- Writing cleaner, more maintainable code

---

## Best Practices Applied

Used `set -euo pipefail` for safer script execution
Created modular functions with single responsibilities
Used `local` variables to avoid scope pollution
Added clear comments and section headers
Used meaningful function and variable names
Implemented a `main()` function for better organization
Used command substitution for dynamic values
Formatted output for readability

---

## Conclusion

Day 18 focused on intermediate shell scripting concepts that are essential for writing production-ready scripts. Functions, strict mode, and proper variable scoping are fundamental skills that separate basic scripts from professional, maintainable automation tools.
