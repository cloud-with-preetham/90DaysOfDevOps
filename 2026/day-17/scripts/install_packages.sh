#!/bin/bash

set -e

# Checking root
if [ "$EUID" -ne 0 ]
then 
	echo "Error: Please run the script as root or (use sudo)" 
	exit 1 
fi

# Verifying package installation

packages=("nginx" "wget" "curl")

for pkg in "${packages[@]}"
do
	if dpkg -s "$pkg" &>/dev/null; then
		echo "$pkg is already installed..!"
	else
		echo "Installing $pkg...!"
		apt-get update -y
		apt install -y "$pkg"
		echo "$pkg installed successfully"
	fi
done
