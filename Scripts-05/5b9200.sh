#!/bin/bash

mkdir copies

if [ ! $RMLOG_FILE ]; then
	echo "env var is not declared yet!"
	exit 1
fi


for f in "$@"; do
	
	if [ -f $f ]; then
		
		cp $f copies/$f
		rm $f
		echo "[date +"%Y-%m-%d %H:%M:%S"] Removed file $f "	

	elif [ -d $f ]; then
		
		if [ -s $f ];then
			cp -r $f copies/$f
			rmdir $s
			echo "[date +"%Y-%m-%d %H:%M:%S"] Removed empty directory $f "

		else

			if [ $2 ] && [ $2 == '-r' ]; then
				cp -r $f copies/$f
				rm -r $f
				echo "[date +"%Y-%m-%d %H:%M:%S"] Removed dir $f recursively"
			else
				echo "Cannot remove non-empty dir $f"
			fi
		fi

	fi
done

