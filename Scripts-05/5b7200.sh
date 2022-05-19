#!/bin/bash

for f in "$@" ; do

#	echo "f - $f"

	if [ -d $f ]; then
		num=$(find $f -maxdepth 1 -type f | wc -l)
		echo "$f is dir with $num files : "
		find $f -maxdepth 1 -type f -size -${num}c -printf "%f\n"

	elif [ -f $f ]; then
		myuid=$(id -u)
		mygid=$(id -g)
		
		fileu=$(stat $f --printf "%u")
		fileg=$(stat $f --printf "%g")
		p=$(stat $f --printf "%A")
#		echo "$myuid $mygid $fileu"

		if [ "$myuid" == "$fileu" ] && [ $(echo $p | cut -c2) == 'r' ]; then
			echo "$f can be read"
		elif [ "$mygid" == "$fileg" ] && [ $(echo $p | cut -c5) == 'r' ]; then
			echo "$f can be read"
		elif [ $(echo $p | cut -c8) == 'r' ]; then
			echo "$f can be read"
		else
			echo "$f cannot be read by us"
		fi


	fi

done
