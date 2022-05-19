#!/bin/bash

if [ $# -ne 3  ]; then
   	exit 1;
fi

if [ ! -f $1 ]; then
   	exit 1;
fi

if [ ! -r $1 ]; then
   	exit 1; 
fi

file=$1;
key1=$2;
key2=$3;

#echo $key1

if [ $(cat $file | egrep "^$key1=" | wc -l ) -ne 1 ]; then
	echo "?"
	exit 2
fi

if [ $(cat $file | egrep "^$key2=" | wc -l) -ne 1 ]; then
	cat $file
	exit 0
fi

k1=$(cat $file | egrep "^$key1=" | cut -d'=' -f 2)
k2=$(cat $file | egrep "^$key2=" | cut -d'=' -f 2)
key=''
while read t; do

	if [ $(echo "$k1" | grep "$t" | wc -l) -eq 0 ]; then
		echo "$key"
	fi


done < <(echo $k2 | sed "s/ /\\n/g")
 
sed "s/$key2=$k2/$key2=$key/g" $file
