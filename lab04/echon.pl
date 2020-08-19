#!/usr/bin/perl
use strict;
use warnings;

if ($#ARGV !=1 ) {
	print "Usage: $0 <number of lines> <string>\n";
	exit 1;
}elsif (( $ARGV[0] =~ /^-?[0-9]+$/ )  && ( $ARGV[0] >= 0) ){
	my $ITER=0;
	while ( $ITER != $ARGV[0] ){
		  $ITER=$ITER+1;
		  print "$ARGV[1]\n";
	}
}else {
	print "$0: argument 1 must be a non-negative integer\n";
	exit 1;
}

