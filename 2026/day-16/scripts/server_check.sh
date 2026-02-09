#!/bin/bash

SERVICE=nginx

read -p "Do you want to check the status of $SERVICE (y/n): " CHOICE

if [ "$CHOICE" = "y" ]; then
	echo "Checking $SERVICE status"
	systemctl status nginx
else
	echo "Skipped"

fi
