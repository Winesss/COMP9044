#!/bin/dash
set -x
#clean workspace
shrug-clean

shrug-init
touch a b c d e f
shrug-add a b c
shrug-commit -m "0"

shrug-rm --force --cached a
shrug-rm --force --cached a
shrug-clean

