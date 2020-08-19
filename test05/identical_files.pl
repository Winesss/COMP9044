#!/usr/bin/perl
use strict;
use warnings;

use File::Compare;

if($#ARGV+1<2){
	print "Usage: $0 \<files\>\n";
	exit 1;
}

my $counter=0;
my $flag=0;
my $mainfile=$ARGV[0];
foreach my $file (@ARGV){
	if ($counter==0){
		$counter=1;
	}else{
		if(compare("$mainfile","$file") != 0){
			print "$file is not identical\n";
			exit 1;
		}			
 
	}
}

if ($flag==0){
	print "All files are identical\n";
}


