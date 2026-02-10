#!/bin/bash

read -p "Enter the number: " num
while [ "$num" -gt 0 ]
do
	echo "$num"
	num=$((num-1))
done

echo "Done!"

