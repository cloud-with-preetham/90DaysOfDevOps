#!/bin/bash

<< usage 
./function.sh hello
inside function call
install_package docker.io
usage

echo "$1 is the main argument passed to the script"

install_package() { # Function definition
	echo "$1 is the local arguments passed to function"
	sudo apt-get install $1
}

# Function call

install_package $1



