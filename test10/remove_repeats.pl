#!/usr/bin/perl
use strict;
use warnings;

my @arr=@ARGV;

foreach (@ARGV) {
	my $flag = 0;
	for(my $count=0; $count < $#ARGV + 1; $count++) {
		if ($_ eq $ARGV[$count]) {
			if ($flag == 0) {
				$flag=1;
			}else{
				delete $arr[$count];
			}
		}
	}
}

my $sep="";
foreach (@arr){
	if (defined $_) {
		print "$sep$_";
		$sep=" ";
	}
}
print "\n";
