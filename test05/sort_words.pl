#!/usr/bin/perl
use strict;
use warnings;

my @line;

while (<STDIN>)
{
	my @sorted_words = sort (split);
	push @line, join(' ',@sorted_words);
}

for (@line)
{
	print "$_\n";
}
