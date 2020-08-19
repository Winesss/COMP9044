#!/usr/bin/perl
use strict;
use warnings;

use File::Copy;


my $count=0;

sub save_snapshot {
	#get the latest snapshot count
	if ( -d ".snapshot.$count") {
		$count=$count+1;
		while(1){
			if (-d ".snapshot.$count") {
				$count=$count+1;				
			} else {
				last;
			}
		}
	}
	

	my @list=grep {!/^snapshot.pl$/} glob "*";
	mkdir ".snapshot.$count/";
	foreach my $filename (@list){
		copy($filename,".snapshot.$count/") or die $!;
	}
	print "Creating snapshot $count\n";
}

if ( "$ARGV[0]" eq "save" ) {
	
	save_snapshot;
	
} 
if ( "$ARGV[0]" eq "load" ) {
	save_snapshot;
	$count=$ARGV[1];
	my @list= glob ".snapshot.$count/*";
	
	foreach my $filename (@list){
		copy("$filename",".") or die "here $filename $!";
	}
	print "Restoring snapshot $count\n";
}

