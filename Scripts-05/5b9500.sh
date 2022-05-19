#!/bin/bash

if [ $# -ne 2 ] ; then
	exit 1;
fi

if [ $1 != "-r" ] && [ $1 != "-g" ] && [ $1 != "-b"]; then
	echo "Unknown color"
	exit 2
fi
text=$2;
if [ $1 == '-r' ]; then
	echo -e "\033[0;31m ${text}"
elif [ $1 == '-g' ]; then
	echo -e "\033[0;32m ${text}"	
else
	echo -e "\033[0;34m ${text}"
fi
echo -e "\033[0m"
