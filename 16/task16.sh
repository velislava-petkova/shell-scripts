#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Must have 1 argument!";
	exit 1;
fi

arg=$1;

if [ !$USER ]; then
	echo $USER;
fi 

if [ $ORACLE ]; then
	echo "nope"
fi


#да се довърши

#$(id -un) -ne 0
if [ "$(whoami)" != "root" ]; then
#	ps -e -o uid,pid,rss

	users=$(mktemp)

	users=$(ps -e -o uid | sort | uniq | head -n -2  > users);
	
	cat users | while read line; do
	current=$(ps -u"$line" -o rss=""| awk 'BEGIN{sum=0}{sum+=$1}END{print sum}')
		if [ $current -gt $arg  ]; then
			echo "We will kill you"
		fi
	done 
fi

