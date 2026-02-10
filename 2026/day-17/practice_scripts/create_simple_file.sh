#!/bin/bash

touch new_file.txt && echo "File has been created" || { 
	echo "File has not been created"; echo "There is some issue with creating the file"
}
