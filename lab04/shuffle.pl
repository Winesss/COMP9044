#!/usr/bin/perl
use strict;
use warnings;
my $i=0;
my @a=();
my @original = @a;

while (my $line = <STDIN>) {
	$a[$i++] = $line;
}

for (my $index=0; $index <= $#a; $index++) {
		my $value = $a[ int(rand(@a)) ];
		($a[$index],$a[$value])=($a[$value],$a[$index]);	
		
	}
print @a;

