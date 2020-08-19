#!/bin/dash

curl --location --silent http://www.timetable.unsw.edu.au/current/${1}KENS.html |egrep "<td class=\"data\"><a href=\"$1.*html\">.*</a></td>"|egrep -v "$1[0-9]{4}</a></td>"|sed 's/\s*<td class="data"><a href="//'| sed 's/<\/a><\/td>$//'|sed 's/.html">/ /'|sort -u| uniq 

