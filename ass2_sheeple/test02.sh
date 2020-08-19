#!/bin/dash

single_param() {
    local a 
    a=$1
	echo -n "parameter is $a"
    return 0
}
single_param "abc" && echo " - single"

#function call with single parameter and echo in single line
