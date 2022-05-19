#!/bin/bash

#echo $PATH

sum=0;

while IFS= read -d ':' line; do
	count=$(find $line -type f -executable | wc -l)
	sum=$((sum+count));
done < <(echo $PATH)

echo ${sum}

#find $PATH -type f -executable | awk 'BEGIN{c=0}{c+=1}END{print c}'
