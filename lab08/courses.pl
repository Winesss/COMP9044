#!/usr/bin/perl -w

use strict;
use warnings;
use LWP::Simple;
use List::MoreUtils qw(uniq);




my $sub =$ARGV[0];
my $url = "http://www.timetable.unsw.edu.au/current/${sub}KENS.html";
my $web_page = get($url) or die "Unable to get $url";


my @text = split "\n", $web_page;

my @out;
foreach my $line(@text){

	chomp $line;

	if ($line =~ "<td class=\"data\"><a href=\"$sub" ) {
		if  ($line !~ "${sub}[0-9]{4}<\/a><\/td>\$" ) {
			$line =~ s/\s*<td class=\"data\"><a href=\"//;
			$line =~ s/<\/a><\/td>//g;
			$line =~ s/.html\">/ /g;

			push @out, $line;
		}
		
	}
	
}
@out = sort @out;
@out =uniq(@out);
foreach (@out){
	print "$_\n";
}

