#!/bin/bash

if [ $# -lt 1 ] ; then
	echo "Must have 1 argument!";
	exit 1;
fi

if [ ! -r $1 ]; then
	echo "File does not exist"
	exit 2
elif [ ! -d $1 ]; then
   echo "File 1 is not a directory"
   exit 3 
fi

if [ $2 ]; then
	if [ ! -r $2 ]; then
		echo "File 2 does not exist"
		exit 2
	elif [ ! -d $2 ]; then
		echo "File 2 is not a directory"
		exit 3
	fi

	dirTo=$2;
else
	dirTo="./$(date +"%T")"
	mkdir $dirTo
fi

dirFrom=$1;

#echo "$dirTo"

find ${dirFrom} -type f -ctime -45 | xargs -I{} cp {} $dirTo  

tar -cvf $dirTo.tar  $dirTo/*


