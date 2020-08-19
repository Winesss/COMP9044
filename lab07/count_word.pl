#!/usr/bin/perl
use strict;
use warnings;

my $word = lc $ARGV[0];
my $count=0;
while (my $line = <STDIN>) {
    my @total = split /\b$word\b/i, $line;
	$count+=scalar @total -1;
}

print "$word occurred $count times\n"
