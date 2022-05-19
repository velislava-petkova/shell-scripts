#!/bin/bash

#proverki

dir=$1;
file=$2;


find ./$dir -type f -printf "%f \n" | while read line; do
	if [ $(cmp "./$dir/$line" $file | wc -l) -eq 0  ]; then
		echo "$line" 
	fi
done

# | xargs -I{} cmp {} ./dir/$file ;\


