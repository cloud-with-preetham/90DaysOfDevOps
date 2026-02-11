#!/bin/bash

# function definition
greet() {
	local name=$1
	echo "Hello,$name"
}

add() {
	local num1="$1"
	local num2="$2"
	echo "Sum: $((num1 + num2))"
}

# calling function

greet Preetham

add 20 90

