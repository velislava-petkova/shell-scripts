#!/bin/bash

if [ $# -lt 1 ] ; then
	echo "Must have at least 1 argument!";
	exit 1;
fi

if [ $(echo $1 | egrep "[^0-9]" | wc -l) -gt 0 ];then
	echo "First argument must be a number"
fi

if [ $2 ]; then
	delim=$2;
else 
	delim=" ";
fi

i=1;
result='';
len=1;

numlen=$(echo $1 | egrep -o [0-9]| wc -l);

while read -n 1 digit; do
	if [ $i -lt 3 ];then
		result="${result}${digit}";
		i=$((i+1));
	elif [ $i -eq 3 ] || [ $len -le $numlen ] ; then
		result="${result}${digit}";
		i=1;
		if [ $len -lt $numlen ]; then
			result="${result}${delim}";
		fi
	fi
	len=$((len+1))

done < <(echo $1 | rev)

result=$(echo $result | rev)
echo $result

