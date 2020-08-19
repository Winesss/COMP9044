#!/usr/bin/perl -w
use Scalar::Util qw(looks_like_number);

#numerical operation
sub numerical{
	$value = $_[0];
	if ($value=~m/\$\(\(.*\)\)/){
		$value=~s/\$|\(|\)//g;
		$value=~s/^\s*|\s*$//g;
		chomp $value;
			
	    @arr=split /\s+/,$value;

	    for($ix = 0; $ix <= $#arr; $ix++) {

			if ($ix%2==0){
				if (looks_like_number $arr[$ix] || $arr[$ix]=~m/\$/) {
					$arr[$ix]="$arr[$ix]";
				}else{
					$arr[$ix]="\$$arr[$ix]";
				}
			}
		}
		$value= join( "", @arr );

	}
	return $value;
}

my %operator = ('-gt', '>', '-lt', '<', '-eq', '==', '-o', '||', '&&', 'and','-le','<=','-ge','>=','-ne','!=','=','eq');
my $filename=$ARGV[0];
our $localflag=0;
open FH, $filename;
while(our $line=<FH>){
	our @funclist;
	my $flag_comment=0;
	our $Pendl="\n";
	#declaration line
	if ($line=~"^#!/bin/.*"){
		print "#!/usr/bin/perl -w$Pendl";
		next;
	}
	
	#print spaces
	$line =~ /^(\s*)/;
    $count = length($1);
	print " " x $count;


	#commented lines
	if ($line=~m/^\s*\#/){
		print "$line";
		next;
	}
	if ($line=~m/\w*\s+\#\s*\w/){
		$flag_comment=1;
		(local $l,our $comment) = split /#/,$line;

		$l=~ s/\s*$//;
		$line=$l;
		chomp $line;
		$Pendl="";
	}
	

	
	#function
	if ($line=~m/\s*{/){
		if($line!~m/(test|while|for)\s*{/){
			chomp $line;
			(my $results) = $line =~ /\w*/g;
			push @funclist,$results;
			print "sub $results {$Pendl";
			$localflag++;
		}
	}
	
	#ARGV assignment
	if($localflag==0){
		if ($line=~m/\$\@|\$\*/){
			$line=~s/\"*(\$\@|\$\*)\"*/\@ARGV/g;

		}
		elsif ($line=~m/\$\#/){
			print "\$numargs=\$\#ARGV+1;\n";
			print " " x $count;
			$line=~s/\$\#/\$numargs/g;
		}elsif($line=~m/\$[0-9]+/){
			my @m = ( $line =~ /\$[0-9]+/g );
			foreach my $arg (@m){
				my @num=split //,$arg;
				if ($num[1]==0){
					$number=$num[1];
				}else{
					$number=$num[1]-1;

					$line =~ s/\"*(\$$num[1])\"*/\$ARGV[$number]/;
				}

				
			}

		}
	}else{
	if ($line=~m/\$\#/){
			print "\$numargs=scalar(\@_);\n";
			$line=~s/\$\#/\$numargs/g;
		}
	# arg assignment subroutine
		if($line=~m/\$[0-9]+/){
			my @m = ( $line =~ /\$[0-9]+/g );
			foreach my $arg (@m){
				my @num=split //,$arg;
				if ($num[1]==0){
					$number=$num[1];
				}else{
					$number=$num[1]-1;

					$line =~ s/\"*(\$$num[1])\"*/\$_[$number]/;
				}
			}

		}	
	}
	
		
	#echo
	if($line =~ m/^\s*echo\s*/){
		#redirection
		if ($line=~m/\>\>\s*\$|\>\s*\$/){
			if ($line=~m/\>\>\s*\$/){
				our $oper=">>";
			}else{
				our $oper=">"
			}
			our @arr=split /$oper/,$line;
			our $fname=$arr[1];
			$line=$arr[0];
			$line=~s/\s*$//;
			$flagredirection=1;
		}else{
			$flagredirection=0;
		}
		
		
		# echo -n option
		if($line =~ m/^\s*echo -n\s*/){
			$endl="";
			$line=~ s/^\s*echo -n\s*//;
		}else{
			$endl="\\n";
			$line=~ s/^\s*echo\s*//;
		}

		
		#single quote or double quote removal
		if ($line=~ m/^'.*'$|^".*"$/){		
			$line=~s/^'|'$|^"|"$//g
		}

		
		#special char escaping
		$line=~s/"/\\"/g;
		chomp $line;
		$line=~ s/^\s*//;	
		if ($flagredirection==1){
			print "open F, '$oper', \$file or die\;$Pendl";
			print " " x $count;
			print "print F \"$line$endl\"\;$Pendl";
			print " " x $count;
			print "close F\;$Pendl";
		}else{
			print "print \"$line$endl\"\;$Pendl";
		}
		
	}

	#system commands
	elsif($line=~m/(^\s*ls\s*|^\s*ls -l\s*|^\s*rm -f\s*|^\s*mv\s*|^\s*cp\s*|^\s*chmod\s*|^\s*rm\s*|^\s*pwd\s*|^\s*date\s*|^\s*id\s*)/){
		$line=~ s/(^\s*|\s*$)//g;
		print "system \"$line\"\;$Pendl";
	}
	
	#local
	elsif($line=~m/^\s*local/){
		$line=~s/^\s*local\s*//;
		chomp $line;
		if ($line=~m/=/){
			if($line=~m/^\s*[\w]*=/){
				$line=~s/^\s*//;
				chomp $line;
				
				my ($var,$val) = split /=/, $line;
				if ($val=~m/^`expr/){
						$val=~s/^`expr|`$|'//g
							
				}
				if (looks_like_number $val){
					print "my \$$var = $val\;$Pendl";
				}else{
						@varnum=split /\s+/, $val;

						if ($#varnum==0){
							if ($val=~m/\$/){
								print "my \$$var = $val\;$Pendl";
							}else{
								print "my \$$var = \'$val\'\;$Pendl";
							}
						}else{
							(my @results) = $val =~ /\$\(\(.*\)\)/g;
							foreach my $argvar(@results){
								$repval=numerical($argvar);

								$val=~s/\Q$argvar/$repval/;
							}
							print "my \$$var = $val\;$Pendl";		
						}
					}
				}
		
			
		}else{
			my @var= split / /, $line;
			print "my (";
			$sep="";
			foreach (@var){
				print "$sep\$$_";
				$sep=", ";
				
			}
			print ");$Pendl";
		}
	}
	
	#variable assign
	elsif($line=~m/^\s*[\w]*=/){
		$line=~s/^\s*//;
		chomp $line;
		
		my ($var,$val) = split /=/, $line;
		if ($val=~m/^`expr/){
				$val=~s/^`expr|`$|'//g
					
		}
		if (looks_like_number $val){
			print "\$$var = $val\;$Pendl";
		}else{
				@varnum=split /\s+/, $val;

				if ($#varnum==0){
					if ($val=~m/\$|".*"/){
						print "\$$var = $val\;$Pendl";
					}else{
						print "\$$var = '$val'\;$Pendl";
					}
				}else{
					(my @results) = $val =~ /\$\(\(.*\)\)/g;
					foreach my $argvar(@results){
						$repval=numerical($argvar);

						$val=~s/\Q$argvar/$repval/;
					}
					print "\$$var = $val\;$Pendl";		
				}
			}
		}
	
	
	# cd command
	elsif($line=~m/^\s*cd/){
		chomp $line;
		$line=~s/^cd /chdir '/;
		print "$line\'\;$Pendl";
	}
	
	#for loop
	elsif($line=~m/^\s*for\s*/){
		chomp $line;
		my @arr = split / /,$line;

		if ($#arr==5){
			print "foreach \$$arr[1] \(\"$arr[3]\",\"$arr[4]\",\"$arr[5]\"\) \{$Pendl";
		}else{
			print "foreach \$$arr[1] \(glob\(\"$arr[3]\"\)\)  \{$Pendl";
		}
	}
	
	#while loop
	elsif($line=~m/^\s*while\s*/){
		if ($line=~m/^\s*while true\s*/){
			print "while (1) {$Pendl";
		}
		if ($line=~/^\s*while\s+test/){

	    	$line=~s/^\s*while\s+test\s*//;
	    	chomp $line;
	    	@arr=split /\s+/,$line;
	    	if ($#arr==2){
		    	if (looks_like_number $arr[0] || looks_like_number $arr[2] || $arr[0]=~m/\$/ || $arr[2]=~m/\$/){
	    			print "while \($arr[0] $operator{$arr[1]} $arr[2]\) \{$Pendl";
	    		}else{
	    			print "while \('$arr[0]' $operator{$arr[1]} '$arr[2]'\) \{$Pendl";
	    		}	
	    	}
	    	
	    	elsif ($#arr==1){
				if ($arr[1]=~m/\$/){
					print "while \($arr[0] $arr[1]\) \{$Pendl";	
				}else{
					print "while \($arr[0] '$arr[1]'\) \{$Pendl";	
				}
	    		
	    		print "while \($arr[0] '$arr[1]'\) \{$Pendl";	
	    	}
	    	
	    	
    	}
    	
    	if ($line=~/^\s*while\s*\[/){

	    	chomp $line;
	    	$line=~s/^\s*while\s*\[\s*//;
	    	$line=~s/\s*]\s*$//;
	    	@arr=split / /,$line;
	    	if ($#arr==1){
		    	print "while\($arr[0] \"$arr[1]\"\) \{$Pendl";		
	    	}else{
	    		print "while \(";
	    		for($ix = 0; $ix <= $#arr; $ix++) {

	    			if ($ix%2==0){
						if (looks_like_number $arr[$ix] || $arr[0]=~m/\$/) {
							print " $arr[$ix]";
						}else{
							print " '$arr[$ix]'";
						}
					}else{
						print " $operator{$arr[$ix]}";
					}
				}
	    		print "\) \{$Pendl";	
	    	
	    	}
    	}
	}
	
	#do then
	elsif ($line =~ m/\s*do\n/ || $line =~ m/\s*then\n/) {
        next;
    }
    
    #empty line
    elsif ($line=~ m/^\s*\n/){

    	print $line;
    }
     #close bracket line
    elsif ($line=~ m/^\s*}/){
    	$line=~s/^s\s*//;
    	print $line;
    	$localflag--;
    }
    
    # done fi
    elsif ($line =~ m/^\s*done/ || $line =~ m/^\s*fi/) {
	    chomp $line;
    	$line=~s/^\s*//;
        print "}$Pendl";
    }
    
    #exit or return command
    elsif ($line=~m/^\s*(exit|return)/){
        chomp $line;
    	$line=~s/^\s*//;
    	print "$line\;$Pendl";
    }
    
    
    #read command
    elsif ($line=~m/^\s*read/){
    	chomp $line;
		$line=~s/\s*read\s*//;

    	print "\$$line = <STDIN>\;$Pendl";
    	print " " x $count;
    	print "chomp \$$line;$Pendl";
    	
    }
    
    #if statement
    elsif ($line=~m/^\s*if\s*/){
    	if ($line=~/^\s*if fgrep/){
	    	chomp $line;
	    	$line=~s/^\s*if\s*//;
	    	print "if \($line\) \{$Pendl";	
    	}
    	if ($line=~/\s*if\s*test/){

	    	$line=~s/^\s*if\s*test\s*|\s*$//;
	    	chomp $line;
	    	@arr=split /\s+/,$line;
	    	if ($#arr==2){
		    		if (looks_like_number $arr[0] || looks_like_number $arr[2] || $arr[0]=~m/\$/ || $arr[2]=~m/\$/){
	    			print "if \($arr[0] $operator{$arr[1]} $arr[2]\) \{$Pendl";
	    		}else{
	    			print "if \('$arr[0]' $operator{$arr[1]} '$arr[2]'\) \{$Pendl";
	    		}	
	    	}
	    	
	    	elsif ($#arr==1){
		    	print "if \($arr[0] \"$arr[1]\"\) \{$Pendl";		
	    	}
	    	
	    	else{

	    		print "if \(";
	    		for($ix = 0; $ix <= $#arr; $ix++) {

	    			if ($ix%2==0){
						if (looks_like_number $arr[$ix] || $arr[0]=~m/\$/) {
							print " $arr[$ix]";
						}else{
							print " '$arr[$ix]'";
						}
					}else{
						print " $operator{$arr[$ix]}";
					}
				}
	    		print "\) \{$Pendl";
	    	}
    	}
    	
    	if ($line=~/^\s*if\s*\[/){

	    	chomp $line;
	    	$line=~s/^\s*if\s*\[\s*//;
	    	$line=~s/\s*]\s*$//;
	    	@arr=split / /,$line;
	    	if ($#arr==1){
		    	print "if \($arr[0] \"$arr[1]\"\) \{$Pendl";		
	    	}else{
	    		print "if \(";
	    		for($ix = 0; $ix <= $#arr; $ix++) {

	    			if ($ix%2==0){
						if (looks_like_number $arr[$ix] || $arr[0]=~m/\$/) {
							print " $arr[$ix]";
						}else{
							print " '$arr[$ix]'";
						}
					}else{
						print " $operator{$arr[$ix]}";
					}
				}
	    		print "\) \{$Pendl";	
	    	
	    	}
    	}
    	
    }
    
    #elif statement
    elsif ($line=~m/^\s*elif\s*/){
    	if ($line=~/^\s*elif fgrep/){
	    	chomp $line;
	    	$line=~s/^\s*elif\s*//;
	    	print "} elsif \($line\) \{$Pendl";	
    	}
    	if ($line=~/\s*elif\s*test/){

	    	$line=~s/^\s*elif\s*test\s*|\s*$//;
	    	chomp $line;
	    	@arr=split /\s+/,$line;
	    	if ($#arr==2){
		    		if (looks_like_number $arr[0] || looks_like_number $arr[2] || $arr[0]=~m/\$/ || $arr[2]=~m/\$/){
	    			print "} elsif \($arr[0] $operator{$arr[1]} $arr[2]\) \{$Pendl";
	    		}else{
	    			print "} elsif \('$arr[0]' $operator{$arr[1]} '$arr[2]'\) \{$Pendl";
	    		}	
	    	}
	    	
	    	elsif ($#arr==1){
		    	print "} elsif \($arr[0] \"$arr[1]\"\) \{$Pendl";		
	    	}
	    	
	    	else{

	    		print "} elsif \(";
	    		for($ix = 0; $ix <= $#arr; $ix++) {

	    			if ($ix%2==0){
						if (looks_like_number $arr[$ix] || $arr[0]=~m/\$/) {
							print " $arr[$ix]";
						}else{
							print " '$arr[$ix]'";
						}
					}else{
						print " $operator{$arr[$ix]}";
					}
				}
	    		print "\) \{$Pendl";
	    	}
    	}
    	
    	if ($line=~/^\s*elif\s*\[/){

	    	chomp $line;
	    	$line=~s/^\s*elif\s*\[\s*//;
	    	$line=~s/\s*]\s*$//;
	    	@arr=split / /,$line;
	    	if ($#arr==1){
		    	print "} elsif \($arr[0] \"$arr[1]\"\) \{$Pendl";		
	    	}else{
	    		print "} elsif \(";
	    		for($ix = 0; $ix <= $#arr; $ix++) {

	    			if ($ix%2==0){
						if (looks_like_number $arr[$ix] || $arr[0]=~m/\$/) {
							print " $arr[$ix]";
						}else{
							print " '$arr[$ix]'";
						}
					}else{
						print " $operator{$arr[$ix]}";
					}
				}
	    		print "\) \{$Pendl";	
	    	
	    	}
    	}
    	
    }
    
    #additional test cases
    elsif($line=~m/^\s*test/){
		$line=~s/^\s*test\s*//;
		chomp $line;
		(my @results) = $line =~ /\$\(\(.*\)\)/g;
		foreach(@results){
			$repval=numerical($_);

			$line=~s/\Q$_/$repval/;
		}
		@arr=split /\s+/,$line;
			for($ix = 0; $ix <= $#arr-3; $ix++) {

				if ($ix%2==0){
					$val=numerical($arr[$ix]);
					print " $val"
				}else{
					print " $operator{$arr[$ix]}";
				}
			}
	
		print " $operator{$arr[-3]} $arr[-2] $arr[-1];$Pendl";
    }# else
    elsif ($line =~ m/^\s*else\n/ ) {
        print "} else {$Pendl";
    }
    
    #parameters for function
    foreach(@funclist){
    	if ($line=~m/$_\s+/){
    		$params=$line;
    		$params=~s/\s*&& echo.*//;
    		$params=~s/^\s*$_\s*//;
    		chomp $params;
    		@par=split /\s+/, $params;
    		$joinedparams= join( ", ", @par );
			$newparams="$_( $joinedparams )";
			$line=~s/$_\s*//;			
			$line=~s/\Q$params/$newparams/;
			print $line if ($line!~m/&& echo/);
    	}
    }
    #additional echo cases
    if ($line=~m/&& echo/){
			(my $results) = $line =~ /&& echo .*/g;
			$results=~s/&& echo\s*|\"//g;
			$line=~s/&& echo .*/or print \"$results\\n\"/;
			chomp $line;
			$line=~s/^\s*|//;
			$line=~s/\s*$//;
			print "$line;$Pendl";

		}
    
    
    
    
    
    
    #commented line print
    if ( $flag_comment == 1 ){
    	print "  # $comment$Pendl";
    }
    	
}
close(FH)


