#!/bin/bash

if [ $# -ne 2 ] ; then
	exit 1;
fi

if [ ! -r $1 ]; then
	echo "File does not exist"
	exit 2
fi

if [ ! -d $1 ]; then
	exit 3
fi

if [ $(echo $2 | egrep "[^0-9]" | wc -l ) -gt 0 ];then
	exit 4
fi

num=$2;
dir=$1;


find $dir -maxdepth 1 -type f -size +${num}c -printf "%s\n" | awk 'BEGIN{sum=0}{sum+=$1}END{print sum}'
