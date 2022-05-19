#!/bin/bash

if [ $# -ne 3 ] ; then
	echo "Must have 3 arguments!";
	exit 10;
fi

#echo $1 $2 $3 | egrep "[^0-9 ]"


if [ $(echo $1 $2 $3| egrep -o "[^0-9 ]" | wc -l) -gt 0 ]; then
	#echo "invalid numbers"	
	exit 3 
fi

left=$2;
right=$3;
num=$1;

if [ ${left} -gt $right ]; then
	exit 2;
fi

if [ $left -gt $num ] || [ $num -gt $right ] ; then
   exit 1;
fi

exit 0;

