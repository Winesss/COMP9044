#!/usr/bin/perl
use strict;
use warnings;
my $count=0;

while (my $line = <STDIN>) {
    my @total = split /[^a-z]+/i, $line;
    foreach my $w (@total) {
    	if ($w =~ /[a-z]/i){
    		$count++ ;
    	}  
    }
}
print "$count words\n";


