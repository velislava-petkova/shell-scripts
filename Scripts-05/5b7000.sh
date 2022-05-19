#!/bin/bash

if [ $# -lt 1 ] ; then
	echo "Must have at least 1 argument!";
	exit 1;
fi


read -p "input string: " str

for line in "$@"; do

	occur=$(cat $line | egrep "$str" | wc -l)
	echo "$line contains $str $occur number of times"

done

