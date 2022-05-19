#!/bin/bash

if [ $# -lt 1 ] ; then
	echo "Must have at least 1 argument!";
	exit 1;
fi

if [ ! $BACKUP_DIR ]; then
	echo "You must create BACKUP_DIR"
	exit 1
fi

rec=0;

if [ $1 == "-r" ]; then 
	shift 1
	rec=1;
fi


while [ -n "$1" ]; do

	file=$1;

	day=$(date +"%y-%m-%H-%M-%S")

	if [ ! -f $file ] && [ ! -d $file ]; then
	  echo "$file must be a regular file or a directory"
  	elif [ -f $file ]; then
	 
		xz $file
		newf="${file}_${day}.xz"
		mv ${file}.xz ${BACKUP_DIR}/${newf}


	elif [ -d $file ]; then
		if [ $(find $file -maxdepth 1 -mindepth 1 | wc -l) -eq 0 ]; then
			newf="${file}_${day}.tgz"
			tar -czf $newf $file
			rmdir ${file}
		#	echo "$file, $newf"
			mv $newf $BACKUP_DIR/$newf
		else

			if [ $rec -eq 0 ]; then
				echo "Cannot remove $file - the dir is not empty"
			
			else 

				newf="${file}_${day}.tgz"
				tar -czf $newf $file
				rm -r ${file}
				mv $newf $BACKUP_DIR/$newf
			
			fi	

		fi
	fi		


shift 1
done
