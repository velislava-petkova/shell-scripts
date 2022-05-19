#!/bin/bash

read -p "Input filename: " file
read -p "Input string: " str

if [ $# -ne 0 ] ; then
	echo "Must have 0 arguments!";
	exit 1;
fi

grep -F -q -s "${str}" "${file}"
echo $?
