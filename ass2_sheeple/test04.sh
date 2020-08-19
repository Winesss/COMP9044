#!/bin/dash
iter=$1
fact=1
while [ $iter -gt 0 ]
do
   fact=$(( $fact * $iter ))
   iter=$(( $iter - 1 ))
done
echo "factorial : $fact"
