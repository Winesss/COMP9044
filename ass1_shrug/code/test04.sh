#!/bin/dash
set -x
#clean workspace
shrug-clean

shrug-init
echo 1 >a 
shrug-rm a
shrug-add a
shrug-rm a
shrug-commit -m "0"
shrug-rm a

echo 1 >a 
shrug-commit -m "1"
shrug-commit -a -m "2"
shrug-add a
shrug-commit -m "2"


shrug-status|egrep -v "diary"|egrep -v "test*"|egrep -v "shrug-*"
shrug-clean
