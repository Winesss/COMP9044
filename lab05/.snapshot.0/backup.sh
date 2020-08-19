#!/bin/sh

if [ "$#" -eq 1 ]
then
	if [ -f "$1" ]
	then
		if [ -f ".$1.0" ]
		then
			count="$(( $(ls -1 ".$1."*|tr '.' '-'|sed s/-.*-//|sort -n|tail -1) + 1 ))"
		else
			count=0
		fi
		cp $1 ".$1.$count"
		echo "Backup of '$1' saved as '.$1.$count'"
	fi
fi
