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
