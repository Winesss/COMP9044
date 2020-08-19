#!/bin/dash

math() {
    local a b
    a=$1
    b=$2
    sum=$(( $a + $b ))
	echo -n "Sum : $a + $b = "
	echo "$sum"
    return $sum
}
math 5 6

#function and parameters
