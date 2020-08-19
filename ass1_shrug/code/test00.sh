#!/bin/dash
set -x
#clean workspace
shrug-clean
#shrug-init working check

ls -d .shrug
shrug-init
ls -d .shrug
shrug-init


echo 1 >a
echo 2 >b

shrug-add a
#check if its in index
cat .shrug/index/a
shrug-commit -m 'first commit'
echo 2 >>a
shrug-add a b
cat .shrug/index/a
cat .shrug/branches/master/a*
shrug-commit -m 'next commit'
cat .shrug/branches/master/a*
cat .shrug/branches/master/b*

shrug-clean
