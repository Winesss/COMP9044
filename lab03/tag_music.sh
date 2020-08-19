#!/bin/sh


for dir in "$@";do
	album="$(echo "$dir"|cut -d'/' -f2|sed 's:/*$::')"
	year="$(echo "$dir"|cut -d'/' -f2|cut -d',' -f2|sed 's/ //'|sed 's:/*$::')"
	ls "$dir"|while read file;do
		track="$(echo "$file"|sed 's/ - /#/g'|cut -d'#' -f1)"
		title="$(echo "$file"|sed 's/ - /#/g'|cut -d'#' -f2)"
		artist="$(echo "$file"|sed 's/ - /#/g'|cut -d'#' -f3|sed 's/.mp3//')"
		id3 -t "$title" -T "$track" -a "$artist" -A "$album" -y "$year" "$dir/$file"  &> /dev/null
	done
done


