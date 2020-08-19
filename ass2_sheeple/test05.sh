#!/bin/dash


for file in *.$1
do	

	if [ -r $file ]
	then
		echo "$file existing in directory"
		cp $file $file.backup
		mv $file.backup $file.backup01
		chmod 755 $file.backup01
		rm $file.backup01
		echo "$file backup created and renamed"
		echo " $file backup permission changed and deleted\n"
	fi

done
