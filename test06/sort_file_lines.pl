#!/usr/bin/perl
use strict;
use warnings;

my @lines;
my $filename = $ARGV[0];

open(IN,'<',$filename) or die $!;
while(<IN>){
	chomp;
	push @lines, $_;
}
close(IN);
my @sorted = sort {	
					length($a) <=> length($b) ||
					$a cmp $b 					
					} @lines;

foreach (@sorted) {
	print "$_\n";
}
