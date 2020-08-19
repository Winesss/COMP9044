#!/usr/bin/perl
use strict;
use warnings;

my $species=$ARGV[0];
my $filename=$ARGV[1];
my $count=0;


open FH, $filename;
my $prev = ""; 
while(my $line = <FH>){
  	chomp $line;
    if ($line=~/$species/) {
		$prev=~s/\s*\"how_many\":\s*|,//g;
		$count+=int($prev);
	}
	$prev = $line; 
}
close(FH);

print "$count\n";
