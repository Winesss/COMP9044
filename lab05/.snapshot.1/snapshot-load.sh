#!/bin/dash


snapshot-save.sh

cp .snapshot.$1/* .

echo "Restoring snapshot $1"
