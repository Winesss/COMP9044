#!/usr/bin/perl
use strict;
use warnings;

my $N=$ARGV[0];

my @lines;
sub snap_check
{
	my $count = 0;
	my $line = $_[0];
	foreach my $l (@lines) {
		if ($line eq $l) {
			$count++;
		}
		if ($count == $N) {
			return 1;
		}
	}
	
	return 0;
}

while(<STDIN>){
	chomp;
	push @lines, $_;
	if (snap_check($_) == 1){
		print "Snap: $_\n";
		exit;
	}
}
