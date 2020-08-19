#!/bin/sh
for img in $*; do
	display $img > /dev/null 2>&1
	echo -n "Address to e-mail this image to? "
	read mailid
	if test $mailid
	then	
		subject=$(echo $img|cut -d'.' -f1)
		echo -n "Message to accompany image? "
		read message
		echo "$message" | mutt -s "$subject!" -a "$img" -- "$mailid"
		echo "$img sent to $mailid"
	fi
done
