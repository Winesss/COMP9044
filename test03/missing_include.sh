#!/bin/sh

for cfile in "$@";do
	for hfile in $( cat $cfile|egrep "^#include \""|sed 's/#include "//'|sed 's/"$//');do
		if ! test -f "$hfile"; then
		
			echo "$hfile included into $cfile does not exist"
		fi
	done
done
