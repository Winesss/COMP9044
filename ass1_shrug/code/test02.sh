#!/bin/dash
set -x
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
ls a b c
ls .shrug/branches/master/*
shrug-clean
