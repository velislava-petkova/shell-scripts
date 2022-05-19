#!/bin/bash

if [ $# -ne 2 ] ; then
	echo "Must have 1 argument!";
	exit 1;
fi

if [ ! -f $1 ]; then
	echo "File does not exist"
	exit 2
fi

if [ ! -f $2 ]; then
	exit 2
fi

size1=$(cat $1 | grep "$1" | wc -l)
size2=$(cat $2 | grep "$2" | wc -l)
file=$1;
if [ $size1 -gt $size2 ]; then
	file=$1
else 
	file=$2
fi

mysongs=${file}.songs

cat $file | while read line; do
	echo $line | cut -d'-' -f2- >> $mysongs

done 

f=$(mktemp)
sort "${file}.songs" > $f;
cat $f> "${file}.songs"
