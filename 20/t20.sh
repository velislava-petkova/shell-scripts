#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Must have 1 argument!";
	exit 1;
fi

if [ ! -f $1 ]; then
	echo "File does not exist"
	exit 2
fi

if [ ! -r $1 ]; then
	exit 3
fi

file=$1;
copy=$(mktemp)

cat $file | cut -d '-' -f2- | awk 'BEGIN{c=0} { c+=1 ; print c "." $0}' >> $copy
cat $copy | sort -t' ' -k2


rm $copy
