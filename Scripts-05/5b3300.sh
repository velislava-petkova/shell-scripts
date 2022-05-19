#!/bin/bash


if [ $# -ne 3 ] ; then
	echo "Must have 3 arguments!";
	exit 1;
fi

paste $1 $2 | sort >> $3 

