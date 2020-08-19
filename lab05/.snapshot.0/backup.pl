#!/usr/bin/perl
use strict;
use warnings;

use File::Copy;
use List::Util qw[min max];

if ( $#ARGV == 0 ) {
	my $filename =$ARGV[0];
	my $count=0;
	if (-e $filename) {
		
    	if (-e ".$filename.$count") {
    		my @file=map { s/.$filename.//r}  (glob ".$filename.*") ;
			foreach my $var (@file){
               	$count=max($count,int($var));	
    		}
    		$count=$count+1;
		}

		copy($filename,".$filename.$count") or die $!;
		print "Backup of '$filename' saved as '.$filename.$count'\n";
	}
}
