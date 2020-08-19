#!/usr/bin/perl
use strict;
use warnings;

sub total_words {
    open(FH, "<", "$_[0]") or die "$!";
    my $wc = 0;

    while (my $line = <FH>) {
        my @total = split /[^a-z]+/i, $line;
		foreach my $w (@total) {
			if ($w =~ /[a-z]/i){
				$wc++ ;
			}  
		}
    }
    close(FH);
    return $wc;
}

sub count_word {
    my $w = lc $_[0];
    my $wc=0;

    open(FH, "<", "$_[1]") or die "$!";
    while (my $line = <FH>) {
	    my @total = split /\b$w\b/i, $line;
		$wc+=scalar @total -1;
    }
    close(FH);
    return $wc;
}

my $word = lc $ARGV[0];

foreach my $file (glob "lyrics/*.txt") {
    my $wc = count_word($word, $file);
    my $total = total_words($file);
    my $logfreq = log(($wc+1)/$total);
    (my $artist) = $file =~ /lyrics\/(.*)\.[^.]*$/;
    $artist =~ tr/_/ /;
    printf("log((%d+1)/%6d) = %8.4f %s\n", $wc, $total, $logfreq, $artist);
}
