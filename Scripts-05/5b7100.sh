#!/bin/bash

if [ $# -ne 2 ] ; then
	exit 1;
fi

if [ ! -d $1 ]; then
	exit 2
fi


if [ $(echo $2 | egrep "[^0-9]" | wc -l) -gt 0 ]; then
	echo "Second argument must be a number"
fi

dir=$1;
num=$2;

find $dir -type f -printf "%s %f\n" | while read line; do
	echo $line | awk -F' ' '$1>'$num' {print $0}' | cut -d' ' -f2-   
done

