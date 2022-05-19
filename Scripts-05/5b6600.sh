#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Must have 1 argument!";
	exit 1;
fi

if [ ! -r $1 ]; then
	echo "File does not exist"
	exit 2
fi

if [ ! -d $1 ]; then
	echo "File is not a directory"
	exit 2
fi

dir=$1
res=$(mktemp)

find $dir -maxdepth 1 -type f  | while read line; do
	sha1sum "${line}" >> $res	
done

todel=$(mktemp)
prev='';

cat $res | sort | while read line; do
	code=$(echo $line| cut -d' ' -f1);
	file=$(echo $line| cut -d' ' -f2);

	if [ "$code" != "$prev" ]; then
		prev=$code
	else 
		echo "$file" >> $todel
	fi
done

cat $todel | while read line; do
	cp "$line" "${line}copy"
	rm $line
	echo "$line is removed "
done 
rm $res
rm $todel
