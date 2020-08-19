#!/bin/dash
one="one"
two="two"
three="three"
echo $one $two $three
for n in $one $two $three
do
    read line
    echo Line $n $line
done

