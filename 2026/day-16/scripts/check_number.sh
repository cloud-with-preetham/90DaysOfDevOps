#!/bin/bash

read -p "Enter the number: " NUM
if [ "$NUM" -gt 0 ]; then
	echo "The number is positive"
elif [ "$NUM" -lt 0 ]; then
	echo "The number is negative"
else
	echo "The number is zero"
fi
