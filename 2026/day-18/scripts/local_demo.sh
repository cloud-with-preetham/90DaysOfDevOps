#!/bin/bash

echo "===== Local v/s Global Variable Demo ====="

# Global variable
message="I am GLOBAL"

# Local variable
use_local() {
	local message="I am LOCAL"
	local temp="Temporary value"

	echo "Inside use_local():"
	echo "message = $message"
	echo "temp = $temp"
}

# Regular variable

use_global() {
	message="Modified by use_global"
	temp="Created globally"

	echo "Inside use_global():"
	echo "message = $message"
	echo "temp = $temp"
}

echo
echo "Before calling functions:"
echo "message = $message"
echo "temp = ${temp:-<undefined>}"

echo
use_local

echo
echo "After use_local():"
echo "message = $message"
echo "temp = ${temp:-<undefined>}"

echo
use_global

echo
echo "After use_global():"
echo "message = $message"
echo "temp = $temp"

