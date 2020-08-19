#!/usr/bin/perl
use strict;
use warnings;

my $backslash="\\";
my $doublequotes="\"";


print " -e print \"";

foreach my $char (split //, $ARGV[1]) {
	if ($char eq $backslash){
		print $backslash;
	}
	if ($char eq $doublequotes){
		print $backslash;
	}
  print "$char";
}

print "\\n\"\n";

