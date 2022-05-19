#!/bin/bash

if [ $# -ne 1 ] ; then
	exit 1;
fi

#echo "$1 $2" | awk -v r=$1 -v c=$2 '{print r/c}'


user=$1;

ps -u "$user" -o rss="",vsz="",pid="" | sort -n -r -k2,2 | while read line; do
	
	rss=$(echo $line|cut -d' ' -f1);
	vsz=$(echo $line| cut -d' ' -f2);
	pid=$(echo $line| cut -d' ' -f3);
	num=$(echo "scale=2; $rss/$vsz" | bc)

	echo $line | awk -F' ' '{print "For process with pid '$pid' rss/vsz='$num'"}'

done
