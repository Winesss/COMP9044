#!/usr/bin/perl
use strict;
use warnings;

my $backslash="\\";
my $doublequotes="\"";
#-e 'print "Perl that prints Perl - yay"'
#" -e print 'hello'"
print " -e print \"";
foreach my $char (split //, $ARGV[0]) {
	if ($char eq $backslash){
		print $backslash;
	}
	if ($char eq $doublequotes){
		print $backslash;
	}
  print "$char";
}
print "\\n\"\n";
