#!/bin/sh
web="$(wget -q -O- 'https://en.wikipedia.org/wiki/Triple_J_Hottest_100?action=raw')"
echo "$web"| egrep "'''\[\[.*,.*\|*[0-9]\]\]'''"|sed 's/.*\[\[//g'|sed 's/\]\].*//g'|while read line; do
	album="$(echo "$line"|cut -d'|' -f1)"
	year="$(echo "$line"|cut -d'|' -f2)"
	mkdir -p "$2/$album"
	track=0
	echo "$web"|sed -n "/$album.*/,/|-/p" | egrep "# "| while read file;do
		track=$(( track+1 ))
		song="$(echo "$file"|awk -F " – " '{print $2}'|sed 's/(.*).*]]//'|sed "s/[][\"]//g"| sed 's/[[:space:]]*$//')"
		artist="$(echo "$file"|awk -F " – " '{print $1}'|sed 's/(.*]] //'|sed "s/[]\[#]//g"|sed 's/.*|//'|sed 's/^ *//g')"
		cp "$1" "$2/$album/$track - $song - $artist.mp3"	
	done
done
