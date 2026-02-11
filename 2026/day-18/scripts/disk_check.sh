#!/bin/bash

# Function definition

check_disk() {
	echo "Disk usage: "
	df -h /
}

check_memory() {
	echo "Available memory: "
	free -h
}

# Calling function

check_disk

check_memory

