#!/usr/bin/perl
use strict;
use warnings;

my $filename=$ARGV[0];

my $count=0;

open(SRC, '<' ,$filename) or die $!;
$count++ while <SRC>;
close(SRC);
open(SRC, '<' , $filename) or die $!;

if ($count%2==0 && $count>0){
#even
	while(my $line =<SRC>){
		if ($. > $count/2 -1){
			print $line;
		}
		last if $. == $count/2+1;
	}
}elsif ($count%2==1 && $count>0){
#odd
	while(my $line =<SRC>){
		if($. == ($count+1)/2){
			print $line;
		}
	}
	last if $. == ($count+1)/2;
}


close(SRC);
