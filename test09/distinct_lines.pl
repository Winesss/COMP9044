#!/usr/bin/perl
use strict;
use warnings;

my $N=$ARGV[0];

my $dist_counter=0;
my $line_counter=0;

my @dist_line;
while ( defined(my $line = <STDIN>) and $dist_counter<$N){
	chomp $line;
	$line=~ s/^\s*|\s*$//g;
	$line=~ s/\s+/ /g;
	$line=lc( $line );
	if (! grep( /^$line$/, @dist_line ) ) {
		push @dist_line, $line;
		$dist_counter++;
	}
	$line_counter++;	
}

if ($dist_counter<$N){
	print "End of input reached after $line_counter lines read - $N different lines not seen.\n"
}else{
	print "$dist_counter distinct lines seen after $line_counter lines read.\n"
}
