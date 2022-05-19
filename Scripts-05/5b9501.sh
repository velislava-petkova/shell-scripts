#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Must have 1 argument!";
	exit 1;
fi

r=$(echo -e "\033[0;31m")
g=$(echo -e "\033[0;32m")
b=$(echo -e "\033[0;34m")

while read line; do
	if [ "$1" == "-x" ]; then
		echo $line
	elif [ "$1" == "-r" ]; then
		echo "$r $line"
		echo "$g $line"
		echo "$b $line"
	elif [ "$1" == "-g" ]; then
		echo "$g $line"
		echo "$b $line"
		echo "$r $line"
	elif [ "$1" == "-b" ]; then
		echo "$b $line"
		echo "$r $line"
		echo "$g $line"
	else 
		echo "unknown color!"
		exit 1
	fi
echo -e "\033[0m"

done
