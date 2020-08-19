#!/usr/bin/perl -w

use strict;
use warnings;

my $N=$ARGV[0];
my $filename = $ARGV[1];

open( my $fh, '<', $filename) or die $!;
while(my $line= <$fh>) {
	if($. == $N) {
		print $line;		
	}
}
close $fh;
