#!/bin/bash


#mkdir a;
#mkdir b;
#mkdir c;

dir=$3
first=$1;
second=$2;

find $dir -type f -printf "%f\n" | while read file; do

	lines=$(cat $dir/$file| wc -l) #number of lines in file
	if [ $lines -lt $first ]; then
		mv $dir/$file a/$file;
	elif [ $lines -lt $second ]; then
		mv $dir/$file b/$file
	else 
		mv $dir/$file c/$file
	fi

done



