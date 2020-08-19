#!/bin/sh
for img in $*; do
	stamp=$(ls -l $img | cut -d' '  -f6,7,8)
	convert -gravity south -pointsize 36 -draw "text 0,10 '$stamp'" $img $img
done
