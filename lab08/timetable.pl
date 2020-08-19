#!/usr/bin/perl -w

use strict;
use warnings;
use LWP::Simple;


foreach my $sub (@ARGV){

	my $url = "http://timetable.unsw.edu.au/current/${sub}.html";
	my $web_page = get($url) or die "Unable to get $url";
	print $web_page;

	my @text = split "\n", $web_page;
}
