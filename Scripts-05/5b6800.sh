#!/bin/bash

if [ $# -gt 2 ] ; then
	exit 1;
fi

if [ ! -r $1 ]; then
	echo "File does not exist"
	exit 2
fi


if [ ! -d $1 ]; then
	echo "Not a dir"
	exit 2
fi


dir=$1

search1=$(mktemp)
search2=$(mktemp)

if [ $2 ]; then
	find $dir -maxdepth 1 -type d,f -printf "%f $s\n" > $search1
else
	find $dir -maxdepth 1 -type d,f -not -name ".*" -printf "%f %s\n" > $search1
fi

cat $search1 | while read line; do
	name=$(echo $line | cut -d' ' -f1);
	size=$(echo $line | cut -d' ' -f2)

	if [ -f $dir/$name ]; then
		echo "${name} (${size} bytes)"
	elif [ -d $dir/$name ]; then
		echo "this is a dir $name in $dir "
		if [ $2 ]; then ent=$(find ${dir}/${name} -maxdepth 1 -type f,d | wc -l)
		else ent=$(find ${dir}/$name -maxdepth 1 -type f,d -not -name ".*" | wc -l);
		fi

		if [ $ent -eq 1 ]; then
			echo "$name ($ent entry)"
		else
			echo "$name ($ent entries)"	
		fi
	fi

done

rm $search1
rm $search2
