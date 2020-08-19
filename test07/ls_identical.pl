#!/usr/bin/perl
use strict;
use warnings;

use File::Cmp qw/fcmp/;
 
print "identical" if fcmp($ARGV[0], $ARGV[1]);
 
fcmp(
  $fh1, $fh2,
  binmode   => ':raw',  # a good default
  fscheck   => 1,       # ... but beware network fs/portability
  RS        => \"4096"  # handy for binary
);
