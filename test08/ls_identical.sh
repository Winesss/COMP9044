#!/bin/sh

if [ -z "$(diff  -s  $1 $2)" ]
then
	ls $1|sort
else
	diff -s $1 $2|egrep "identical"| sed 's/ and .*//'|sed 's/^Files.*\///'
fi
