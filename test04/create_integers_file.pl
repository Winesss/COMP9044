#!/usr/bin/perl -w
use strict;
use warnings;

my $filename=$ARGV[2];
open( my $fh, '>', $filename) or die $!;
for my $i ( $ARGV[0]..$ARGV[1] ) {
	print $fh "$i\n";
}
close $fh;
