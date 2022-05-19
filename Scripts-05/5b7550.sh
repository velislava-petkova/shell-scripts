#!/bin/bash

if [ $# -ne 1 ]; then 
	echo "1 rgument needed"
	exit 1
fi

user=$1;

if [ $(cat /etc/passwd | egrep "^$user:" | wc -l) -ne 1 ]; then
	echo "incorrect username"
	exit 2
fi

c=$(ps -u "$user" -o pid="" r | wc -l)

ps -u "$user" -o pid="" r | while read p; do
	kill -15 $r 2>/dev/null
done

echo "Number of running process for user $user is $c"


