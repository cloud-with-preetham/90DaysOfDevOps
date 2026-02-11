#!/bin/bash

# function definition

demo_local() {
	local local_var="I am a local user"
	echo "Inside function: "
	echo "$local_var"
}

demo_global() {
	regular_var="I am not a local user"

}

# calling function

demo_local
echo "Outside function: "
echo "${local_var:-local_var is not accessible}"

demo_global
echo "$regular_var"
