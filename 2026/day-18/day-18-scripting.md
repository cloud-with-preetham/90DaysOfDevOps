# Day 18 Shell Scripts

This folder contains Bash script examples focused on functions, variable scope, strict mode, and basic system monitoring.

## Table of Contents

- [Project Structure](#project-structure)
- [Files](#files)
- [disk_check.sh](#disk_checksh)
- [functions.sh](#functionssh)
- [local_demo.sh](#local_demosh)
- [strict_demo.sh](#strict_demosh)
- [system_info.sh](#system_infosh)
- [Quick Start](#quick-start)
- [Notes](#notes)

## Project Structure

```text
day-18/
└── scripts/
    ├── README.md
    ├── disk_check.sh
    ├── functions.sh
    ├── local_demo.sh
    ├── strict_demo.sh
    └── system_info.sh
```

## Files

### `disk_check.sh`
Prints disk and memory usage using two functions:
- `check_disk`: runs `df -h /`
- `check_memory`: runs `free -h`

Run:
```bash
./disk_check.sh
```

---

### `functions.sh`
Demonstrates reusable functions with parameters:
- `greet <name>` prints a greeting
- `add <num1> <num2>` prints the arithmetic sum

Current script call:
- `greet Preetham`
- `add 20 90`

Run:
```bash
./functions.sh
```

---

### `local_demo.sh`
Shows difference between local and global variables:
- `demo_local` defines `local_var` with `local` (function scope)
- `demo_global` defines `regular_var` without `local` (global scope)

Expected behavior:
- Inside function, `local_var` is visible
- Outside function, `local_var` is not accessible
- `regular_var` remains accessible after function call

Run:
```bash
./local_demo.sh
```

---

### `strict_demo.sh`
Demonstrates strict Bash mode:
```bash
set -euo pipefail
```

What it currently does:
- prints `Strict mode enabled`
- references `UNDEFINED_VAR`
- includes a failing command (`false`)
- includes a failing pipeline (`grep ... | wc -l`)

Important:
Because `set -u` is enabled, the script exits at `UNDEFINED_VAR` first, so later checks may not run unless that line is changed/commented.

Run:
```bash
./strict_demo.sh
```

---

### `system_info.sh`
A function-based system summary script using strict mode. It prints:
- kernel info (`uname -r`)
- uptime (`uptime`)
- disk usage snapshot (`df -h /`)
- memory usage (`free -h`)
- top CPU-consuming processes (`ps aux --sort=-%cpu | head -n 6`)

Run:
```bash
./system_info.sh
```

## Quick Start

From this directory:
```bash
chmod +x *.sh
./disk_check.sh
./functions.sh
./local_demo.sh
./strict_demo.sh
./system_info.sh
```

## Notes

- Scripts are written for Bash (`#!/bin/bash`).
- `strict_demo.sh` is intentionally designed to fail fast for learning strict mode behavior.
