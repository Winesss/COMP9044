#!/bin/dash


value=599
echo $value
if [ $value -eq 500 ]
then
  echo "value is 500"
else
  if [ $value -gt 500 ]
  then
    echo "value is greater than 500"
  else
  echo "value is less than 500"
  fi
fi
#if else nested


value=59
echo $value
if test $value -eq 500
then
  echo "value is 500"
else
  if test $value -gt 500
  then
    echo "value is greater than 500"
  else
  echo "value is less than 500"
  fi
fi

#if else nested with test
