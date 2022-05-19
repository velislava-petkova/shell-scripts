#!/bin/bash

LOGDIR=$1;

#find $LOGDIR -mindepth 3 -type f -printf "%P\n" | sort -t'/' -k3,3 | xargs -I{}	wc -l $LOGDIR/{} 

friends=$(mktemp)

find $LOGDIR -mindepth 3 -type f -printf "%P\n" | sort -t '/' -k3,3 | while read line; do

	lines=$(cat $LOGDIR/$line | wc -l);
	friend=$(echo $line | cut -d'/' -f3);
	
	if [ $(cat $friends | grep -c "$friend" ) -eq 0 ]; then 
		echo "$friend $lines" >> $friends
	else 
		cat $friends | awk '$1=='$friend' {$2+='$lines'}'
	fi
done

cat $friends | sort -n -t' ' -k2,2 | tail 

rm $friends
