#!/bin/bash

if [ $# -ne 3 ] ; then
	echo "Must have 3  arguments!";
	exit 1;
fi

if [ ! -r $1 ]; then
	echo "File does not exist"
	exit 2
fi
name=$2;
username=$3;

#count=$(cat /etc/passwd | tr ',' ':' |	egrep "^([^:]+:){4}\<${name}\>:" | wc -l)
count=$(cat /etc/passwd | grep "${name}" | wc -l)


if [ $count -eq 1 ]; then
	echo "$username <username на $name в os-server>" >> $1
fi
i=1;

if [ $count -gt 1 ]; then
	
	result='';	
	while read -r line; do
		echo "$i $line" 
		result="$result $line \t"
		i=$((i+1))
	done < <(cat /etc/passwd | tr ',' ':'| grep "${name}" | cut -d':' -f5)
	
	read -p "Enter line number: " num
	name=$(echo ${result} | sed 's/\\t/\n/g' | head -n $num | tail -n 1) 
	echo "$username <username на $name в os-server>" >>$1
	
fi
