#!/usr/bin/perl
use strict;
use warnings;


my %artist_wc;
my %total_words;
sub get_logfreq {
	my $word = $_[0];
	my %prob_table;
	foreach my $file (glob "lyrics/*.txt") {	
		my $wc = $artist_wc{$file}{$word};
		$wc = 0 if (!$wc);
		my $total = $total_words{$file};
		my $logfreq = log(($wc+1)/$total);
		
		(my $artist) = $file =~ /lyrics\/(.*)\.[^.]*$/;
	    $artist =~ tr/_/ /;
		$prob_table{$artist} = $logfreq;
	}
	return %prob_table;
}


sub get_word {
	my $song = $_[0];
	my %word_table;
	open(FH, "<", "$song") or die "$!";
	while (my $line = <FH>) {
        chomp $line;
        $line = lc $line;
		my @words = split /[^a-z]+/i, $line;
        
        foreach my $w (@words) {
			if (!$word_table{$w}) {
				$word_table{$w} = 1;
			} else {
				$word_table{$w}++;
			}
         }
	}
	close(FH);
	return %word_table;
}


foreach my $file (glob "lyrics/*.txt") {
	open(FH, "<", "$file") or die "$!";
	while (my $line = <FH>) {
		chomp $line;
        $line = lc $line;
        my @total = split /[^a-z]+/i, $line;
		foreach my $w (@total) {
			if ($w =~ /[a-z]/i){
				if (!$artist_wc{$file}{$w}) {
					$artist_wc{$file}{$w} = 1;
				} else {
					$artist_wc{$file}{$w}++;
				}
				
				if (!$total_words{$file}) {
					$total_words{$file} = 1;
				} else {
					$total_words{$file}++;
				}
			}
		}
	}
	close(FH);
}


my %artist_prob;
for my $song (@ARGV) {
	my %songword_table = get_word($song);

	foreach my $word (keys %songword_table) {
		my %artist_wordfreq = get_logfreq($word);
		
		foreach my $artist (keys %artist_wordfreq) {
			$artist_prob{$artist} += $artist_wordfreq{$artist} * $songword_table{$word};
		}
	}

	my $final = (keys %artist_prob)[0];
	my $max = $artist_prob{$final};   
	foreach my $artist (keys %artist_prob) {
		if ($max < $artist_prob{$artist}) {
			$max = $artist_prob{$artist};
			$final = $artist;
		}
	}
	

	printf("%s most resembles the work of %s (log-probability=%.1f)\n", $song,$final,$max);
	undef %artist_prob;
	undef %songword_table;
}
