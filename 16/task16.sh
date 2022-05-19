#!/bin/bash

if [ $# -ne 1 ]; then
	echo "1 arg!"
	exit 1
fi

#proverka chislo

num=$1;

if [ $(id -un) == "s62428" ]; then
	
	ps -e --no-header -o user,rss,pid | sort -r -n | awk '{
	if($1==prev){
	sum+=$2;
	biggest=$3;
	}
	else{
	printf prev" : "sum"\n"
	if ( biggest>'$num'){
		printf "and we must kill process with pid "biggest"\n"
	}
	
	sum=$2;
	prev=$1;
	biggest=$3;

	}
   
	}'

fi
