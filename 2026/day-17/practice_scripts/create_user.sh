#!/bin/bash

<<usage
- Take user name as input
- Take password as input
- check if user already exists
- create the user
usage

# function definition

create_user() {
	read -p "Enter your username: " username
	read -p "Enter your password: " password

	if id $username &>/dev/null; then
		echo "The user $username exists, exiting the code"
		exit 1
	else
		echo "The user $username does not exist and user will be created...!"
	fi

	sudo useradd -m $username -p $password
	echo "User $username added successfully"
}
