#!/bin/bash
echo "enter first date in mm/dd/yy >> "
read date1
echo "enter second date in mm/dd/yy >> "
read date2

second1=$(date -d "$date1" +%s)
second2=$(date -d "$date2" +%s)
if ((second2 >= second1))
then
	echo "($second2-$second1)/86400"|bc
else
	echo "($second1-$second2)/86400"|bc
fi
