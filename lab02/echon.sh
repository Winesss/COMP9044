#!/bin/bash

if (($# != 2))
then
	echo "Usage: $0 <number of lines> <string>"
	exit 1
elif [[ "$1" =~ ^-?[0-9]+$ ]] && (($1>=0))
then	
	ITER=0
	while (( $ITER != $1 ))
	do
		  ITER=$ITER+1
		  echo "$2"
	done
else
	echo "$0: argument 1 must be a non-negative integer"
	exit 1
fi
