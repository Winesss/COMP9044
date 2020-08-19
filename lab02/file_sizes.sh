#!/bin/bash

files=$(ls)

for f in $files
do
	if (( $(cat $f|wc -l)<10 ))
	then	
		small+=( "$f" )
	elif (( $(cat $f|wc -l)>=10 )) && (( $(cat $f|wc -l)<100 ))
	then
		medium+=( "$f" )
	else
		large+=( "$f" )
	fi
done

printf '%s ' "Small files: ${small[@]}"
echo ""
printf '%s ' "Medium-sized files: ${medium[@]}"
echo ""
printf '%s ' "Large files: ${large[@]}"
echo ""
