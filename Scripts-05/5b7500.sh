#!/bin/bash

a=$1;
b=$2;

if [ $(echo "${a}${b}" | egrep "[^0-9]" | wc -l) -gt 0 ]; then
	echo "arguments must be numbers"
	exit 1
fi


if [ $a -ge $b ]; then
	echo "Invalid interval"
	exit 2
fi

num=$(( (RANDOM % b) + a ));
c=0;

while true; do
	c=$((c+1))
	read -p "Guess? " g;
	if [ $g -gt $num ]; then
		echo "...smaller!"
	elif [ $g -lt $num ]; then
		echo "...bigger!"
	else 
		echo "RIGHT! Guessed $num in $c tries!"
		break;
	fi
done


