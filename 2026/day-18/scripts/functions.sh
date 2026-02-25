#!/bin/bash

greet() {
	name=$1
	echo "Hello, $1..!"
}

add() {
	num1=$1
	num2=$2
	sum=$((num1+num2))
	echo "Sum: ${sum}"
}

greet "Alice"
add 509 60

