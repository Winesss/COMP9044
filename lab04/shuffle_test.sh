#!/bin/bash

seq $1 $2 >numbers.txt
echo -n "original sequence : "
array=$(cat numbers.txt)
echo $array

flag=1
while [ $flag ]
do
	solution=$(./shuffle.pl <numbers.txt)
	echo -n "shuffled sequence : "
	echo $solution
	if [ "$array" != "$solution" ]
	then
		flag=0
	fi
done
