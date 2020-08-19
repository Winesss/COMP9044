#!/bin/sh

for i in *.jpg; do
    fname=${i%.*}
    if test $(ls|egrep "$fname.png")
    then
	echo "$fname.png already exists"
    else
	convert "$fname.jpg" "$fname.png"
	rm "$fname.jpg"
    fi
done
