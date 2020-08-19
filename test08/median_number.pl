#!/usr/bin/perl

use strict;
use warnings;

my @nums = sort {$b <=> $a} @ARGV;
my $index = int($#nums/2);
print "$nums[$index]\n";
