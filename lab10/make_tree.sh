#!/bin/sh

arr=( $(find $1|egrep "Makefile"|sed "s/\/Makefile//" |tr "\n" " ") )
currdir="$(pwd)"

for i in "${arr[@]}"
do
	cd $i
	echo "Running make in $i"
	if [ $# -gt 1 ]
	then
		make $2
	else
		make
	fi
	cd $currdir
done

