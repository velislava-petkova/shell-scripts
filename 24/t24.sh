#!/bin/bash

dir=$1;

if [ $# -eq 2 ]; then
   
	num=$2;
	find $dir -type f -links +$((num-1)) 

else

	find $dir -xtype l

fi   
