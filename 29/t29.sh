#!/bin/bash

if [ $(id -un) != "s62428" ]; then
	echo "nope"
	exit 1
fi

users=$(mktemp);

cat /etc/passwd | tail -n +2 | while read line; do

user=$(echo $line | cut -d':' -f1);
homedir=$(echo $line | cut -d':' -f6);
if [ ! -d $homedir ]; then
#	echo "$homedir does not exist"
	echo $user >> $users
	continue;
fi

dirowner=$(stat $homedir -c"%U");
if [ $dirowner != $user ]; then
#	echo "$dirowner is different than $user"
	echo $user >> $users
	continue;
fi

writePerm=$(stat $homedir -c "%A" | cut -c 3 );

if [ $writePerm != "w" ]; then
   echo $user >> $users
	continue;   
fi

done

rootRSS=$(ps -u "root" -o rss="" | awk '{rss+=$1}END{print rss}')

cat $users | while read line; do

#извеждаме инфо за нужните потребители
#	ps -u "$line" -o user="",pid="",rss=""
	userRSS=$(ps -u "$line" -o rss="" | awk 'BEGIN{rss=0}{rss+=$1}END{print rss}')
	if [ $userRSS -gt $rootRSS ]; then
		ps -u "$line" -o pid="" | xargs -I {} kill -SIGTERM {} 2>/dev/null
	fi

done

rm $users
