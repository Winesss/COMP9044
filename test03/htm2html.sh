#!/bin/bash

for var in $(ls *.htm*|cat)
do	
	if test $(echo "$var"|egrep ".htm$")
	then
		if test -f "${var}l"; then
		    echo "${var}l exists"
		    exit 1
		else	
			mv "${var}" "${var}l"
		fi
	fi
done
