#!/bin/bash

while IFS= read -r line; do
  echo "$line"|tr '[01234]' '<'|tr '[6789]' '>'
done
