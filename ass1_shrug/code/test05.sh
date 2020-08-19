#!/bin/dash
set -x
#clean workspace
shrug-clean

shrug-init
echo 1 >a 
shrug-rm a
shrug-add a
shrug-rm --force a

shrug-add a
shrug-commit -m "0"
echo 2 >a
shrug-rm a


shrug-status|egrep -v "diary"|egrep -v "test*"|egrep -v "shrug-*"
shrug-clean
