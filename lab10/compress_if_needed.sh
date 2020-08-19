#!/bin/sh

for i in $@
do
    act_mem=$(( $(stat -c '%n %s' $i|cut -d ' ' -f2) + 0 ))
    xz $i
    new_mem=$(( $(stat -c '%n %s' $i.xz|cut -d ' ' -f2) + 0 ))
    if [ $act_mem -gt $new_mem ]
    then
    	echo "$i $act_mem bytes, compresses to $new_mem bytes, compressed"
    else
    	echo "$i $act_mem bytes, compresses to $new_mem bytes, left uncompressed"
    	xz -d $1.xz
    fi
done

