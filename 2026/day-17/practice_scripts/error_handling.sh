#!/bin/bash

set -e # eliminates the task if anything fails

<<usage 
create a folder
usage

mkdir devops || mkdir -p devops &>/dev/null

echo "Start production work..!"

touch new-file.txt; || echo "The file was not created"; echo "Demo file" > new-file.txt
