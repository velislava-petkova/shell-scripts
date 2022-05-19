#!/bin/bash

if [ $# -ne 0 ]; then exit 1; fi

users=$(mktemp)
data=$(mktemp)
cat /etc/passwd | cut -d':' -f 1,6 >> $users

mintime=0;

while read user; do

	u=$(echo $user | cut -d ':' -f1)
	h=$(echo $user | cut -d ':' -f2)
	find $h -type f -printf "%T@ %u %f\n" 2>/dev/null >> $data

done < <(cat $users)

cat $data | sort -n -t' ' -k 1,1 | sed '/^$/d' | head -n 1 | cut -d ' ' -f2-

rm $users
rm $data
