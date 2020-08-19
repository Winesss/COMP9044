#!/usr/bin/perl -w

my $date =`date`;
print "# Makefile generated at $date\n";
print "CC = gcc\nCFLAGS = -Wall -g\n\n";
our @cfiles = glob("*.c");

our @hfiles = glob("*.h");
our %dependecies;

my $mainfile = find_main(\@cfiles);


find_dep(\@cfiles);


my $num=0;
while ($num<size_hash()){
	$num=size_hash();
	circular_dep();
}

print "$mainfile:\t";
foreach my $cfile (@cfiles) {
	$cfile =~ s{\.[^.]+$}{};
    print "$cfile.o ";
}
print "\n";
print "\t\$\(CC\) \$\(CFLAGS\) -o \$@ ";
foreach my $cfile (@cfiles) {
	$cfile =~ s{\.[^.]+$}{};
    print "$cfile.o ";
}
print "\n";

foreach my $arg (keys %dependecies) {
	my $cfile="$arg";
	$arg =~ s{\.[^.]+$}{};

    print "$arg.o: @{$dependecies{$cfile}} $cfile\n";
}



sub find_main
{
	my @cfiles = @{$_[0]};
	foreach (@cfiles)
	{
		open FILE, "$_";
		while (my $line = <FILE>) {
			if ($line =~ /^\s*(int|void)\s*main\s*\(/) {
				$_ =~ s{\.[^.]+$}{};
				return $_;
			}
		}
		close(FILE);
	}

	return 0;
}

sub find_dep
{
	my @cfiles = @{$_[0]};
	foreach (@cfiles)
	{
		open FILE, "$_";
		
		while (my $line = <FILE>) {
			if ($line =~ /^\s*#include\s*\".*.h\"\s*/) {
				$line =~ s/^\s*#include\s*\"//;
				$line =~ s/\"\s*//;
				my $dep=$line;
				push( @{$dependecies{$_}}, $dep );
				
				
			}
		}
		close(FILE);
	}
}

sub circular_dep
{	
	foreach (keys %dependecies) {
		my @value_arr;
		foreach my $value (@{$dependecies{$_}}){
			open FILE, "$value";
			while (my $line = <FILE>) {
				if ($line =~ /^\s*#include\s*\".*.h\"\s*/) {
					$line =~ s/^\s*#include\s*\"//;
					$line =~ s/\"\s*//;
					my $dep=$line;

					push( @value_arr, $dep )unless grep{$_ eq $dep} @value_arr;
				}
			}
			close(FILE);
		}
		
		foreach my $dep(@value_arr){
			push @{$dependecies{$_}}, $dep unless grep{$_ eq $dep} @{$dependecies{$_}};
		}
		
	}
}

sub size_hash
{
	my $num=0;
	foreach (keys %dependecies) {
		foreach my $value (@{$dependecies{$_}}){
			$num++;
		}
	}
	return $num;
}

