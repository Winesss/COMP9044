#!/bin/sh

for i in $@
do
    echo -n "$i "
	curl -s -I $i|egrep -i "^server"|sed s'/server:\s*//'i
done

