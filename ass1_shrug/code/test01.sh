#!/bin/dash
set -x
#clean workspace
shrug-clean

shrug-init
#log without commit
shrug-log

echo line 1 > a

# error no file
shrug-add b
#empty index nothing to commmit
shrug-commit -m 'first commit'

#log for each commit upating
shrug-add a
echo 1 >b
shrug-add b
shrug-commit -m 'first commit'
shrug-log


echo line 2 >> a
shrug-add a
shrug-commit -m 'second commit'
shrug-log

#show for index and repo file
echo line 3 >> a
shrug-add a
shrug-show 0:a
shrug-show 1:a
shrug-show :a
cat a


shrug-show 0:b
shrug-show 1:b
shrug-show :b
cat b

shrug-clean
