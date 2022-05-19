#!/bin/bash

src=$1;
dst=$2;
string=$3;

find $src -type f -name "*$string*" -printf "%P\n" | while read line; do

newDir=$(echo $line | awk -F '/' '{
if (NF>1){
	for(i=1; i<NF; i++)
	printf $i"/";
}
}')

filename=$(basename $line)
if [ -n $newDir ]; then
	mkdir -p $dst/$newDir
mv $src/$line $dst/$newDir/$filename

else
   	mv $src/$filename $dst
fi

done
