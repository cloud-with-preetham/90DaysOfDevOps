#!/bin/bash

SERVICE="ngnix"

read -p "Do you want to check the status (y/n): " CHOICE

if [[ $CHOICE == "y" || $CHOICE == "Y" ]]; then
	if systemctl is-active --quiet "$SERVICE"; then
		echo "Service $SERVICE is active..."
	else
		echo "Service $SERVICE is not active..."
	fi
elif [[ $CHOICE == "n" || $CHOICE == "N" ]]; then
	echo "Skipped..."

else
	echo "Invalid input. Please enter y or n."
fi
