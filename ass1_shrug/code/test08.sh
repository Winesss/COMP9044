#!/bin/dash
set -x
#clean workspace
shrug-clean

shrug-init
touch a b c d e f

shrug-add a b c d
shrug-commit -m "0"
ls .shrug/branches/master/

shrug-rm --force a
shrug-commit -a -m "1"
echo 2 >>b
echo 3 >>c

rm e

shrug-status|egrep -v "diary"|egrep -v "test*"|egrep -v "shrug-*"
shrug-clean
