#!/bin/bash

fname=$1

res="$(cat $fname |egrep "^COMP[29]041"|cut -d'|' -f3|cut -d ',' -f2|sed 's/ *$//'|sed 's/^ *//'|sed 's/ .*$//'|sort|uniq -c|sort|tail -1|sed 's/^ *[0-9]* //')"

echo $res
