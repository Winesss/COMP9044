#!/usr/bin/perl
use strict;
use warnings;
use File::Copy;


my $filename   = $ARGV[0];
open(SRC,'<',$filename) or die $!;
open(DES,'>',"$filename.new") or die $!;
while(<SRC>)
{
    $_ =~ s/[0-9]/#/g;
    print DES $_;
}
close(SRC);
close(DES);
copy("$filename.new","$filename") or die $!;
unlink("$filename.new")  or die $!;
