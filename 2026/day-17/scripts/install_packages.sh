#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Run the script with root privilages..."
	echo "Usage: sudo ./install_packages.sh"
	exit 1
fi

packages=( "nginx" "curl" "docker.io" )

apt-get update -y 

for pkg in "${packages[@]}"
do
	echo "-----------------------"
	echo "Checking: $pkg"

	if dpkg -s "pkg" &>/dev/null
	then
		echo "$pkg is installed...!"
		exit 1
	else
		echo "$pkg is not installed...!"
		echo "Installing $pkg......"

		apt-get install -y "$pkg"

		if [ $? -eq 0 ]
		then
			echo "$pkg installed successfully....!"
		else
			echo "Failed to install $pkg....!"
		fi
	fi
done

echo "---------------------"
echo "All checks completed!"

