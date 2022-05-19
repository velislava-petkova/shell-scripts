#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Must have 1 argument!";
	exit 1;
fi

if [ ! -d $1 ]; then 
   echo "Incorrect argument type"
   exit 1
fi

dir=$1;

find $dir -xtype l
