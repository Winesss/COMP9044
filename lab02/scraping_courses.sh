#!/bin/sh

first_letter=$(printf %.1s "$1")

curl --silent "http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=$first_letter"|grep "$1.*html"|awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }'|cut -d'>' -f2|cut -d'/' -f7|cut -d'.' -f1 > code.txt

curl --silent "http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=$first_letter"|grep "$1.*html"|awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }'|cut -d'>' -f3|cut -d'<' -f1 |awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }'> course.txt > course.txt

paste -d' ' code.txt course.txt > under.txt
rm code.txt course.txt

curl --silent "http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=$first_letter"|grep "$1.*html"|awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }'|cut -d'>' -f2|cut -d'/' -f7|cut -d'.' -f1 > code.txt
curl --silent "http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=$first_letter"|grep "$1.*html"|awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }'|cut -d'>' -f3|cut -d'<' -f1|awk '{ gsub(/^[ \t]+|[ \t]+$/, ""); print }' > course.txt > course.txt


paste -d' ' code.txt course.txt > post.txt
rm code.txt course.txt

cat under.txt post.txt |sort|uniq


rm under.txt post.txt
