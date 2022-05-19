#!/bin/bash

if [ $# -ne 0 ] ; then
	echo "Must have 0 argument!";
	exit 1;
fi

if [ $(id -u) -eq 0 ]; then
	echo "not root"
	exit 2;
fi

mypasswd=$(mktemp)
cat ./my_passwd > $mypasswd;
#cat $mypasswd
result=$(mktemp);

while read line; do

	homedir=$(echo $line | awk -F ':' ' {print $6}');
#	echo "homedir: $homedir"
	user=$(echo $line | awk -F ':' '{print $1}')

	if [ ! -d $homedir ] || [ -z $homedir ]; then
		echo $user >> $result;
	else
		perm=$(stat "${homedir}" --printf "%A\n")
		dirowner=$(stat "${homedir}" --printf "%u\n" ); #owner of given dir
		curuser=$(id -u $user);	#user we are cheking
		
		dirgroup=$(stat "${homedir}" --printf "%g\n") #group owner of given dir 
		groups=$(mktemp); #which groups our user is in

		hasperm=0;

		id -G $user | tr ' ' "\n" >> $groups

		if [ "$dirowner" == "$curuser" ] ; then
			if 	[ $(echo $perm | cut -c 3) != 'w' ] ; then
				echo $user >> $result
			else 
				hasperm=1;	
			fi
	
		elif [ $( cat $groups | grep "$dirgroup" | wc -l ) -gt 0 ]; then
		   if	[ "$(echo $perm | cut -c 6)" != 'w' ]; then
				echo $user >> $result
			else
				hasperm=1;
		   fi


		elif [ $hasperm -eq 0  ] && [ "$(echo $perm | cut -c 9 )" != 'w' ]; then
			echo $user >> $result
		fi


		rm $groups

	fi

done < <(cat $mypasswd)

cat $result

rm $result
rm $mypasswd;
