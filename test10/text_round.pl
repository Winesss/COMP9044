#!/usr/bin/perl
use strict;
use warnings;

my @MatchArray;

while (my $line =<STDIN> ){
	chomp $line;
	@MatchArray = $line =~ /[-+]?[0-9]*\.?[0-9]+/g;

	foreach my $NUM (@MatchArray){
		my $round_NUM = int($NUM);
		if ($NUM-$round_NUM >= 0.5 ){
			$round_NUM=$round_NUM+1;
		}
		$line=~s/$NUM/$round_NUM/;
	}
	print "$line\n";
}


