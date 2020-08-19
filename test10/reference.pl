#!/usr/bin/perl -w


my %hash;
my $count=1;

while (my $line =<STDIN> ){
	chomp $line;
	$hash{$count}=$line;
	$count++;
	
}
foreach $k (sort keys %hash) {
	$v=$hash{$k};
    if ($v=~/^#[0-9]+/){
   		$v=~s/^#//;
   		$hash{$k}=$hash{$v};
   	}
   	print "$hash{$k}\n";
}
