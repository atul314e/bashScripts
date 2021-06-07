#!/bin/bash
day=$(date +%d)
month=$(date +%m)
year=$(date +%y)
daysInMonth=(31 30 31 30 31 30 31 31 30 31 30 31)
turns=${daysInMonth[$month-1]} 
for (( i=$day; i<=$turns; i++ ))
do
	echo "$month/$i/$year"
done

