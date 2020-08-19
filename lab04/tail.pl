#!/usr/bin/perl
use strict;
use warnings;

my $tailCount = 0;
if (@ARGV) {
	if ( $ARGV[0] =~ m/^-\d+$/) {
		$tailCount = shift @ARGV;
	} else {
		$tailCount = -10;
	}
	my @fileList = @ARGV;


	foreach my $fileName (@fileList) {
	      open(F,"<$fileName") or print "$0: Can't open $fileName\n" and next;
	      my @array = <F>;
	      print "==> $fileName <==\n" if @fileList > 1; 
	      if (@array + $tailCount < 1) {
		 print @array;
	      } else {
		 print @array[$tailCount..-1];
	      }
	      close(F);
	}
} else {
	my @array=();
	my $index = 0;

	while(my $f = <STDIN>){
		$array[$index++] = $f;

	}

	my $count = $index-10;
	while($count < $index){
		print $array[$count++];
	}
}
