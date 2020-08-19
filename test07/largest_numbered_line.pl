#!/usr/bin/perl
use strict;
use warnings;

my $largest;
my $matchLine;
my @MatchArray;

while (my $line =<STDIN> ){
  chomp $line;
  @MatchArray = $line =~ /[-+]?[0-9]*\.?[0-9]+/g;

  foreach my $NUM (@MatchArray){
      #First Line
      if (!$largest){
        $largest=$NUM;
        $matchLine="$line\n";
      } elsif ($largest < $NUM) { #if greater
        $largest=$NUM;
        $matchLine="$line\n";
      } elsif ($largest==$NUM) { #if same concatenate
        $matchLine .= "$line\n";
      }
  }
}

if (defined $matchLine){ #check for no Line
  print "$matchLine";
}
