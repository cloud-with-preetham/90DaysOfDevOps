
#!/bin/bash

set -euo pipefail

# Function definition

print_header() {
	echo "=================================="
	echo "$1"
	echo "=================================="
}

system_info() {
	print_header "Hostname & Operating System"
	uname -r
}

uptime_info() {
	print_header "System Information"
	uptime
}

disk_info() {
	print_header "Top 5 Directories by Size"
	df -h / 2>/dev/null | sort -rh | head -n 5
}

memory_info() {
	print_header "Memory Usage"
	free -h
}

cpu_info() {
	print_header "Top 5 CPU-consuming processes"
	ps aux --sort=-%cpu | head -n 6
}

main() {
	system_info
	uptime_info
	disk_info
	memory_info
	cpu_info
}

# calling function
main

