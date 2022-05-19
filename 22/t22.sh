#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Must have 1 argument!";
	exit 1;
fi

if [ $(id -un) != "s62428" ]; then
	id -u
	exit 0;
fi

user=$1;
userPr=$(ps -u "$user" -o pid=""| wc -l)

#a
#echo "Users with processes less than those of $user "
ps -e --no-header -o user | sort | uniq -c | tr -s ' ' | sed "s/ //" | awk '$1>'$userPr' {print $2}'

#b

#echo "Usernames and average working time of processes of all users in seconds"
average=$(ps -e -o times | awk 'BEGIN{c=0; time}{c++; time+=$1; } END {if (c>0) print time/c;
else print "0"}')

echo $average

ps --no-header -u "$user" -o pid,times | awk '$2<average {print $1}' | while read pr; do
	echo "we need to kill $pr"
	kill -15 $pr
done
