#!/usr/bin/perl

use strict;
use warnings;

use File::Compare;
use File::Basename;

my @out;
my @dir1 = glob("$ARGV[0]/*");
my @dir2 = glob("$ARGV[1]/*");

foreach my $file1(@dir1){
	foreach my $file2(@dir2){
		my $fname1 =basename($file1);
		my $fname2 =basename($file2);
		if($fname1 eq $fname2){
			if(compare($file1,$file2)==0){
				push @out,$fname1;
			}elsif(-z $file1 and -z $file2){
				push @out,$fname1;
			}
		}
	}
}

my @sorted_out = sort {$a cmp $b} @out;

foreach (@sorted_out){
	print "$_\n";
}
