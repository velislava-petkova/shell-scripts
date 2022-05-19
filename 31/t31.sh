#!/bin/bash

if [ $# -ne 2 ]; then 
	echo "nope"
	exit 1
fi

if [ ! -f $1 ]; then
	echo "invalid file"
	exit 2
fi

if [ ! -d $2 ]; then
	echo "invalid dir"
	exit 2
fi

if [ $(find $2 -mindepth 1 | wc -l ) -gt 0 ]; then
	echo "dir must be empty "
#	exit 3
fi

DIR=$2;
STEN=$1;

#touch $DIR/dict.txt

i=100;

while read line; do
	firstname=$(echo $line | awk '{print $1}')
	lastname=$(echo $line | cut -d':' -f1 |awk '{print $2}')

	if [ $(cat $DIR/dict.txt | egrep -c "^$firstname[[:space:]]+$lastname"  ) -eq 0 ]; then
		echo "$firstname $lastname;$i" >> $DIR/dict.txt
		touch $DIR/$i
		i=$((i+1));
	fi
done < <(cat $STEN)

cat $DIR/dict.txt | while read line; do

	file=$(echo $line | cut -d ';' -f2)
	firstname=$(echo $line | cut -d' ' -f1)
	lastname=$(echo $line | cut -d';' -f1 | cut -d' ' -f2 )

	cat $STEN | egrep "^$firstname[[:space:]]+$lastname" >> $DIR/$file
	
done


