#!/usr/bin/perl
use strict;
use warnings;

my $x='aeiou';
my @arr;

foreach my $arg(@ARGV){
	if ($arg =~ /[$x]{3,}/i){
		push @arr,$arg;
	}
}

my $sep="";
foreach (@arr){
	print "$sep$_";
	$sep=" ";
}
print "\n";
