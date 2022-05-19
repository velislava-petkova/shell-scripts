#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Must have 1 argument!";
	exit 1;
fi

userId=$1;

while sleep 1; do

if [ $(echo $(who | cut -d' ' -f1 | sort | uniq | xargs id ) | grep -o "$userId") ]; then
	echo "User with id $userId is logged in. Bye!"
	exit 0
fi

echo "still not here $(date +"%T")"


done

