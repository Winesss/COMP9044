#!/bin/dash

dirname="snapshot"
if [ -d ".$dirname.0" ]
then
	count="$(( $(ls -1d ".$dirname."*|tr '.' '-'|sed s/-.*-//|sort -n|tail -1) + 1 ))"
else
	count=0
fi

mkdir ".$dirname.$count"
cp $(ls -I snapshot-load.sh  -I snapshot-save.sh) ".$dirname.$count"

echo "Creating snapshot $count"
