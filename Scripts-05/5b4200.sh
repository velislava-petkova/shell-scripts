#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Must have 1 argument!";
	exit 1;
fi

if [ ! -r $1 ]; then
	echo "File does not exist"
	exit 2
fi

nestNum=0;
maxnest=0;

while read -n 1 char; do
#echo "$char - "
	if [ "$char" = "{" ] ; then

		nestNum=$((nestNum+1))
		if [ $nestNum -gt $maxnest ]; then
			maxnest=$nestNum;
		fi
	elif [ "$char" == "}" ] ; then
		nestNum=$((nestNum-1))
	fi
done < <(cat $1)

echo $maxnest
