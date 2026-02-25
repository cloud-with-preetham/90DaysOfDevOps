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
