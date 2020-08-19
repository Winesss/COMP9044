#!/bin/dash

#clean workspace
shrug-clean
shrug-init
echo 1 >a
echo 2 >b
echo 3 >c
shrug-add a b
echo 1 >>a
echo 2 >>b
echo 3 >>c
shrug-commit -a -m "commit all"
#check if c is not added
rm a
shrug-add c
shrug-rm --cached b
ls a b c
echo 4 >d
shrug-add d
shrug-commit -m "1"
ls .shrug/branches/master
shrug-rm d
shrug-status|egrep -v "diary"|egrep -v "test*"|egrep -v "shrug-*"
shrug-clean
