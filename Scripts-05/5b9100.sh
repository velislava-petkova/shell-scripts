#!/bin/bash

SOURCE=$1;
DESTINATION=$2;

files=$(mktemp)

find $SOURCE -maxdepth 1 -type f -printf "%f\n" > $files

cat $files | awk -F'.' '{print $NF}' | sort | uniq 2>/dev/null | while read line; do

	mkdir $DESTINATION/$line 2>/dev/null
#	echo $DESTINATION/$line

done

cat $files | while read line; do

	currentfile=$line;
	ext=$(echo $line | awk -F'.' '{print $NF}' )
	
	mv $SOURCE/$currentfile $DESTINATION/$ext  2>/dev/null

done

rm $files

