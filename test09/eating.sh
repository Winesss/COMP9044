#!/bin/sh

cat $1|egrep "{.*}"|sed 's/^[ \t]*//;s/[ \t]*$//'|sed "s/[{}]//g"|cut -d',' -f1|sed "s/\"name\": //"|sed "s/\"//g"|sort|uniq
