#!/bin/bash

read -p "Log absolute path: " dir

if [ $# -ne 0 ] ; then
	echo "Must have 0 arguments!";
	exit 1;
fi


dirs="$(find $dir -mindepth 1 -type d | wc -l)"
files="$(find $dir -mindepth 1 -type f| wc -l)"

echo "In $dir there are $dirs directories and $files files"


