#!/bin/bash
dir1=$1
dir2=$2
if [ -d "$dir2" ]
then
	mount --bind $dir1 $dir2
else
	mkdir $dir2
	mount --bind $dir1 $dir2
fi
